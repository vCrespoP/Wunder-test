import Foundation

import Domain

import RxSwift
import RxCocoa

final class ListPresenter: BasePresenter {

    // MARK: - Properties
    fileprivate let persistenceProvider: UseCasePersistenceProvider
    fileprivate let dataSourceProvider: UseCaseDataSourceProvider
    fileprivate let navigator: ListNavigator
    weak fileprivate var view: ListViewController?

    var datasource: Vehicles?

    // MARK: - Life Cycle
    init(persistenceProvider: UseCasePersistenceProvider, dataSourceProvider: UseCaseDataSourceProvider, navigator: ListNavigator, view: ListViewController) {
        self.persistenceProvider = persistenceProvider
        self.dataSourceProvider = dataSourceProvider
        self.navigator = navigator
        self.view = view

        super.init(view: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.onFetchData()
    }

}

// MARK: - Public Methods
extension ListPresenter {

    func onFetchData() {

        if datasource == nil {
            self.view?.showLoadingDialog()
            self.view?.hideTable()
        }

        let context = Application.shared.context.operationContext

        self.dataSourceProvider
            .makeUseCaseVehiclesGetAll()
            .getAll(context: context)
            .subscribe(onNext: { [weak self] responseVehicles in
                guard let vehicles = responseVehicles.data else {
                    return
                }

                // Store response
                self?.storeData(vehicles: vehicles)

                // Sort results by distance to user
                let currentLocation = Application.shared.context.currentLocation
                let vehiclesSorted = vehicles.sortedByDistance(from: currentLocation)

                // Refresh UI
                self?.datasource = vehiclesSorted
                self?.view?.reloadView()
                }, onError: { error in

            }, onCompleted: {

            }, onDisposed: {

            })
            .disposed(by: self.disposeBag)

    }

}

// MARK: - Private Methods
extension ListPresenter {

    func storeData(vehicles: Vehicles) {

        let context = Application.shared.context.operationContext

        self.persistenceProvider
            .makeUseCaseVehiclesStoreAll()
            .store(vehicles: vehicles, context: context)
            .subscribe(onNext: { storedVehicles in
                Log.debug("\(storedVehicles.count) vehicles stored")

            }, onError: { [weak self] error in
                self?.view?.show(error: error)

                }, onCompleted: {

            }, onDisposed: {

            })
            .disposed(by: self.disposeBag)
    }

}
