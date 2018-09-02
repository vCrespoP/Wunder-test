import Foundation

public protocol UseCasePersistenceProvider {

    // MARK: Vehicles
    func makeUseCaseVehiclesStoreAll() -> UseCasesVehiclesPersistence
    func makeUseCaseVehiclesGetAll() -> UseCasesVehiclesPersistence

}
