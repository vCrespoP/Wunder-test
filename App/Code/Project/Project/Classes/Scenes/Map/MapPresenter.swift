import Foundation

import Domain

import RxSwift
import RxCocoa

final class MapPresenter: BasePresenter {

    // MARK: - Properties
    fileprivate let persistenceProvider: UseCasePersistenceProvider
    fileprivate let dataSourceProvider: UseCaseDataSourceProvider
    fileprivate let navigator: MapNavigator
    weak fileprivate var view: MapViewController?
    var items: Vehicles?

    // MARK: - Life Cycle
    init(persistenceProvider: UseCasePersistenceProvider, dataSourceProvider: UseCaseDataSourceProvider, navigator: MapNavigator, view: MapViewController) {
        self.persistenceProvider = persistenceProvider
        self.dataSourceProvider = dataSourceProvider
        self.navigator = navigator
        self.view = view

        super.init(view: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Center view in Hamburg for now
        let latitude = 53.542220
        let longitude = 10.001810
        let regionRadius: Double = 0.5 * 1000

        self.view?.centerOn(latitude: latitude, longitude: longitude, regionRadius: regionRadius)

        // Request data
        self.loadVehicles()

    }

}

// MARK: - Public Methods
extension MapPresenter {

    func onList() {
        self.navigator.toList()
    }

    func loadVehicles() {
        let context = Application.shared.context.operationContext

        self.dataSourceProvider
            .makeUseCaseVehiclesGetAll()
            .getAll(context: context)
            .subscribe(onNext: { [weak self] responseVehicles in
                guard let vehicles = responseVehicles.data else {
                    return
                }

                // Store data
                self?.items = vehicles
                self?.storeData(vehicles: vehicles)

                // Reload UI
                self?.view?.fillWith(vehicles: vehicles)

                }, onError: { error in

            }, onCompleted: {

            }, onDisposed: {

            })
            .disposed(by: self.disposeBag)
    }

}

// MARK: - Private Methods
extension MapPresenter {

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
