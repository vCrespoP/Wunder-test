import Foundation

import UIKit
import Domain
import SharedUtils

// MARK: - Protocol
protocol ListNavigator {
    func toView()

}

// MARK: - Default
class DefaultListNavigator: ListNavigator {

    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    private let persistenceProvider: UseCasePersistenceProvider
    private let dataSourceProvider: UseCaseDataSourceProvider

    init(persistenceProvider: UseCasePersistenceProvider, dataSourceProvider: UseCaseDataSourceProvider, navigationController: UINavigationController) {
        self.persistenceProvider = persistenceProvider
        self.dataSourceProvider = dataSourceProvider
        self.navigationController = navigationController
        self.storyboard = ListViewController.storyboard
    }

    func toView() {
        let vc: ListViewController = storyboard.instantiateInitialViewController()
        vc.presenter = ListPresenter(persistenceProvider: persistenceProvider, dataSourceProvider: self.dataSourceProvider, navigator: self, view: vc)
        navigationController.pushViewController(vc, animated: true)
    }

}

