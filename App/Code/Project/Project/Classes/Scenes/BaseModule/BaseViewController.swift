import UIKit
import Foundation

import Domain
import NetworkSpecific

import RxSwift

import PureLayout

class BaseViewController: UIViewController, ViewControllerMessages, LoadingHud, StateController {

    // Protocol properties
    var loadingView: StatefulViewProtocol?
    var errorView: StatefulViewProtocol?
    var infoView: StatefulViewProtocol?

    //
    // MARK: Properties
    //
    let disposeBag = DisposeBag()

    //
    // MARK: Outlets
    //

    //
    // MARK: Life Cycle
    //

    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingView = ViewStatefulDefault.createView(in: self.view)
        errorView = ViewStatefulDefault.createView(in: self.view)
        infoView = ViewStatefulDefault.createView(in: self.view)

        self.showOriginalView()

        self.initViewController()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    //
    // MARK: Initialization
    //
    func initViewController() {
        self.translation()
        self.initUI()
    }

    func translation() {
        //        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "GLOBAL_BACK".localizedTRN, style: .plain, target: nil, action: nil)
    }

    func initUI() {
        self.view.backgroundColor = ThemeColor.bgPrimaryLight
        self.navigationController?.navigationBar.barStyle = .blackOpaque

        self.placeLogoInNavigationBar()
    }

    func show(error: Error) {

        Log.error("Show error: \(error)")

        if let errorResponse = error as? ErrorResponse {
            let errorMessage = "Temporary unavailable" // TODO: Translate
            Log.error(errorResponse)
            self.showError(text: errorMessage)
            return
        }

        guard let prError = error as? PRError else {
            Log.error("Not treating error: \(error)")
            return
        }

        switch prError {

        default:
            Log.error("PRError not treated: \(error)")
            self.showError(text: "Temporary unavailable")  // TODO: Translate
        }

    }

    func showError(text: String, title: String = "Oops".localized) { // TODO: Translate
        let message = Message(title: title, text: text) // TODO: Translate
        let acceptAction = MessageAction(title: "Ok".localized, style: .default, handler: { }) // TODO: Translate
        self.showInformation(message: message, accept: acceptAction)
    }

    func showDemoLimitation() {
        self.showMessage(title: "Not included in demo, soon!", type: .error) // TODO: Translate
    }

}
