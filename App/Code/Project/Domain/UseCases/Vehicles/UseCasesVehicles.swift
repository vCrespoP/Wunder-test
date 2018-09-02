import Foundation

import RxSwift

public enum UseCasesVehicles {

    /// Requests data for all available vehicles
    public static func getAll(context: OperationContext, dataSource: UseCaseDataSourceProvider, persistence: UseCasePersistenceProvider) -> Observable<SuccessResponse<Vehicles>> {

        let opDataSource: Observable<SuccessResponse<Vehicles>> = dataSource
            .makeUseCaseVehiclesGetAll()
            .getAll(context: context)

        // Any further logic to filter, convert, etc.

        return opDataSource

    }

    /// Stores data for all given vehicles
    public static func storeAll(vehicles: Vehicles, context: OperationContext, persistence: UseCasePersistenceProvider) -> Observable<Vehicles> {

        let opPersistence = persistence
            .makeUseCaseVehiclesStoreAll()
            .store(vehicles: vehicles, context: context)

        // Any further logic to filter, convert, etc.

        return opPersistence

    }

    /// Reads data for all available vehicles
    public static func readAll(context: OperationContext, persistence: UseCasePersistenceProvider) -> Observable<Vehicles> {

        let opPersistence = persistence
            .makeUseCaseVehiclesGetAll()
            .readAll(context: context)

        // Any further logic to filter, convert, etc.

        return opPersistence
    }

}

