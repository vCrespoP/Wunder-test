import Foundation

public protocol UseCaseDataSourceProvider {

    // MARK: Vehicles
    func makeUseCaseVehiclesGetAll() -> UseCasesVehiclesDataSource
}

