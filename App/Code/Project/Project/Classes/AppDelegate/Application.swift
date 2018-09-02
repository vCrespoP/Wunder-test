import Foundation
import UIKit

import Domain

import PlatformNetworkApi
import PlatformNetworkStatic
import SharedUtils
import RxSwift
import ReSwift

final class Application {

    // MARK: Properties
    static let shared = Application()
    var logger: Logger
    var disposeBag = DisposeBag()
    let dataSourceProviderConfiguration: DataSourceConfiguration
    let persistenceProviderConfiguration: PersistenceConfiguration
    var context: ApplicationContext
    let store: Store<AppState>
    var reduxComponents: [String: Any] = [:]

    var environment: ApiEnvironment {
        set {
            dataSourceProviderConfiguration.environment = newValue
        }
        get {
            return dataSourceProviderConfiguration.environment
        }
    }

    // MARK: Life Cycle
    private init() {
        self.dataSourceProviderConfiguration = DataSourceConfiguration()

        // Log init
        #if CONFIGURATION_Release
        self.logger = EmptyLogger()
        #else
        self.logger = ConsoleLogger()
        #endif

        self.persistenceProviderConfiguration = PersistenceConfiguration()

        // Redux
        self.store = Application.initStore()
        self.context = ApplicationContext(store: self.store)
        self.initReduxComponents(store: self.store)
        self.startUpdatingUserLocation(store: self.store)

        self.initKeyboardManager()
        self.initCrashlytics()
        self.initHUD()
        self.trackVersion()
        self.customizeAppearence()

    }

    /// Initializes Redux store and its middleware
    private static func initStore() -> Store<AppState> {
        var middleware: [Middleware<AppState>] = []
        #if CONFIGURATION_Release
        // No Middleware
        #else
        middleware.append(loggingMiddleware)
        #endif

        let appState = AppState.default

        let store = Store<AppState>(reducer: appReducer, state: appState, middleware: middleware)
        return store
    }

    /// Redux components
    private func initReduxComponents(store: Store<AppState>) {
        self.reduxComponents = [
            "location": LocationComponent(store: store)
        ]
    }

    /// Requests permissions and starts tracking user's location
    private func startUpdatingUserLocation(store: Store<AppState>) {

        guard let locationComponent = self.reduxComponents["location"] as? LocationComponent else {
            return
        }

        locationComponent.requestWhenInUseAuthorization()
        locationComponent.startUpdatingLocation()

    }

}

extension Application {

    /// Presents initial view
    func configureMainInterface(in window: UIWindow) {
        self.showMap(in: window)
    }

    /// Map scene navigation
    func showMap(in window: UIWindow) {
        let navigationController = PRNavigationController()
        let navigator = DefaultMapNavigator(
            persistenceProvider: persistenceProviderConfiguration.getType(for: .map),
            dataSourceProvider: dataSourceProviderConfiguration.getType(for: .map),
            navigationController: navigationController
        )
        window.replaceAnimated(navigationController: navigationController)

        navigator.toView()
    }

}

import IQKeyboardManager
import PKHUD
import Fabric
import Crashlytics
import AppVersionMonitor

extension Application {

    /// Automatic handling of the keyboard
    fileprivate func initKeyboardManager() {
        IQKeyboardManager.shared().isEnabled = true
    }

    /// Crash report system
    fileprivate func initCrashlytics() {
        // TODO: Uncomment when ready
        //        Fabric.with( [ Crashlytics.self ] )
    }

    /// Loading/progress hud
    fileprivate func initHUD () {
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
    }

}

extension Application {

    /// Start tracking version to detect upgrade, fresh installation, etc.
    fileprivate func trackVersion() {
        AppVersionMonitor.sharedMonitor.startup()
    }

    /// Unifies all app appearance
    fileprivate func customizeAppearence() {

        // Custom image for back

        //        let backArrowImage = UIImage(named: BackArrow)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        //        UINavigationBar.appearance().backIndicatorImage = backArrowImage
        //        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backArrowImage

        // Customize navigation bar
        let fontColor  = ThemeColor.bgSecondaryDark
        let backgroundColor = ThemeColor.barTintColor

        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: fontColor
        ]

        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = fontColor
        UINavigationBar.appearance().barTintColor = backgroundColor
        UINavigationBar.appearance().backgroundImage(for: .default)

        // Custom appearence
        //        UISwitch.appearance().onTintColor = secondaryTextColor
        //        UIStepper.appearance().tintColor = secondaryTextColor

    }

    /// Context for operations such as shared properties, logger, etc.
    static var operationContext: OperationContext {
        return Application.shared.context.operationContext
    }

}
