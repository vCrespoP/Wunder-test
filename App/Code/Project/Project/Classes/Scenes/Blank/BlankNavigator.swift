import Foundation

import UIKit
import Domain
import SharedUtils

// MARK: - Protocol
protocol BlankNavigator {
    func toView()

}

// MARK: - Default
class DefaultBlankNavigator: BlankNavigator {

    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    private let persistenceProvider: UseCasePersistenceProvider
    private let dataSourceProvider: UseCaseDataSourceProvider

    init(persistenceProvider: UseCasePersistenceProvider, dataSourceProvider: UseCaseDataSourceProvider, navigationController: UINavigationController) {
        self.persistenceProvider = persistenceProvider
        self.dataSourceProvider = dataSourceProvider
        self.navigationController = navigationController
        self.storyboard = BlankViewController.storyboard
    }

    func toView() {
        let vc: BlankViewController = storyboard.instantiateInitialViewController()
        vc.presenter = BlankPresenter(persistenceProvider: persistenceProvider, dataSourceProvider: self.dataSourceProvider, navigator: self, view: vc)
        navigationController.pushViewController(vc, animated: true)
    }

}

