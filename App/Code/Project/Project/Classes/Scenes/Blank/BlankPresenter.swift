import Foundation

import Domain

import RxSwift
import RxCocoa

final class BlankPresenter: BasePresenter {

    // MARK: - Properties
    fileprivate let persistenceProvider: UseCasePersistenceProvider
    fileprivate let dataSourceProvider: UseCaseDataSourceProvider
    fileprivate let navigator: BlankNavigator
    weak fileprivate var view: BlankViewController?

    // MARK: - Life Cycle
    init(persistenceProvider: UseCasePersistenceProvider, dataSourceProvider: UseCaseDataSourceProvider, navigator: BlankNavigator, view: BlankViewController) {
        self.persistenceProvider = persistenceProvider
        self.dataSourceProvider = dataSourceProvider
        self.navigator = navigator
        self.view = view

        super.init(view: view)
    }

}

// MARK: - Public Methods
extension BlankPresenter {

    func onAction() {

        //        RegistrationUseCase
        //            .login(user: username, password: password, persistence: self.persistenceProvider.makeUseCaseLogin())
        //            .flatMap { user in
        //                return RegistrationUseCase.setCurrentUser(user, persistence: self.persistenceProvider.makeUseCaseSetCurrentUser())
        //            }
        //            .subscribe(
        //                onNext: { [weak self] _ in
        //                    Log.debug("Logged in")
        //                    self?.navigator.toStartView()
        //                },
        //                onError: { [weak self] error in
        //                    self?.view?.show(error: error)
        //                },
        //                onCompleted: {
        //
        //            },
        //                onDisposed: { [weak self] in
        //                    self?.view?.hideLoadingDialog()
        //                }
        //        ).disposed(by: disposeBag)

    }

}

// MARK: - Private Methods
extension BlankPresenter {

}
