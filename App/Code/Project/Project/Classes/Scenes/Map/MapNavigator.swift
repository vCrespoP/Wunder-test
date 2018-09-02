import Foundation

import UIKit
import Domain
import SharedUtils

// MARK: - Protocol
protocol MapNavigator {
    func toView()
    func toList()
}

// MARK: - Default
class DefaultMapNavigator: MapNavigator {

    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    private let persistenceProvider: UseCasePersistenceProvider
    private let dataSourceProvider: UseCaseDataSourceProvider

    init(persistenceProvider: UseCasePersistenceProvider, dataSourceProvider: UseCaseDataSourceProvider, navigationController: UINavigationController) {
        self.persistenceProvider = persistenceProvider
        self.dataSourceProvider = dataSourceProvider
        self.navigationController = navigationController
        self.storyboard = MapViewController.storyboard
    }

    func toView() {
        let vc: MapViewController = storyboard.instantiateInitialViewController()
        vc.presenter = MapPresenter(persistenceProvider: persistenceProvider, dataSourceProvider: self.dataSourceProvider, navigator: self, view: vc)
        navigationController.pushViewController(vc, animated: true)
    }

    func toList() {
        let persistenceProvider = Application.shared.persistenceProviderConfiguration.getType(for: .list)
        let dataSourceProvider = Application.shared.dataSourceProviderConfiguration.getType(for: .list)
        let navigator = DefaultListNavigator(
            persistenceProvider: persistenceProvider,
            dataSourceProvider: dataSourceProvider,
            navigationController: self.navigationController
        )
        navigator.toView()
    }

}

