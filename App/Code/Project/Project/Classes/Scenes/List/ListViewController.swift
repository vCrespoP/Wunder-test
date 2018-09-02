import UIKit

import Log
import RxSwift
import RxCocoa
import Domain

import ReSwift

class ListViewController: BaseViewController {

    // MARK: - Properties
    var presenter: ListPresenter?
    let refreshControl = UIRefreshControl()
    var previousState: AppState?

    // MARK: - Outlets
    @IBOutlet weak var tvContent: UITableView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        Application.shared.store.dispatchMain(LocationAction.resumeUpdates)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Application.shared.store.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        Application.shared.store.unsubscribe(self)

        super.viewWillDisappear(animated)
    }

    // MARK: - Initialization
    override func translation() {
        self.title = ""
    }

    override func initUI() {
        super.initUI()

        self.configureTable()
    }

}

// MARK: - Public methods
extension ListViewController {

    @objc func refreshData(_ sender: Any) {
        self.presenter?.onFetchData()
    }

    func hideTable() {
        self.tvContent.alpha = 0.0
        self.tvContent.isHidden = true
    }

    func showTable() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.tvContent.isHidden = false
            self?.tvContent.alpha = 1.0
        })
    }

    func reloadView() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.hideLoadingDialog()

            self.showTable()

            self.tvContent.reloadData()
        }
    }

}

// MARK: - Private methods
extension ListViewController {

}
