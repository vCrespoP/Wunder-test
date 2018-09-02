import Foundation

import Domain

public final class UseCasePersistenceProvider {

    // MARK: - Properties

    // MARK: - Life Cycle
    public init() { }

}

extension UseCasePersistenceProvider: Domain.UseCasePersistenceProvider {

    public func makeUseCaseVehiclesStoreAll() -> Domain.UseCasesVehiclesPersistence {
        return UseCasesVehiclesPersistence()
    }

    public func makeUseCaseVehiclesGetAll() -> Domain.UseCasesVehiclesPersistence {
        return UseCasesVehiclesPersistence()
    }
}
