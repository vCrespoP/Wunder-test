import UIKit

import Log
import RxSwift
import RxCocoa
import TRNRemoteLocalization
import Domain

class BlankViewController: BaseViewController {

    // MARK: - Properties
    var presenter: BlankPresenter?

    // MARK: - Outlets

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    // MARK: - Initialization
    override func translation() {
        self.title = ""
    }

    override func initUI() {
        super.initUI()

    }

}

// MARK: - Public methods
extension BlankViewController {

}

// MARK: - Private methods
extension BlankViewController {

}
