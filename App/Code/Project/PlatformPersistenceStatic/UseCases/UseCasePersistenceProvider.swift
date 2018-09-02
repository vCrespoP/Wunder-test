import Foundation

import Domain

public final class UseCasePersistenceProvider {

    // MARK: - Properties
    private let responseType: ResponseType
    private let delay: TimeInterval

    // MARK: - Life Cycle
    public init(responseType: ResponseType = .success(code: 200), delay: TimeInterval = 0.0) {
        self.responseType = responseType
        self.delay = delay
    }

}

extension UseCasePersistenceProvider: Domain.UseCasePersistenceProvider {

    // MARK: Vehicles
    public func makeUseCaseVehiclesStoreAll() -> Domain.UseCasesVehiclesPersistence {
        return UseCasesVehiclesPersistence(responseType: self.responseType, delay: self.delay)
    }
    public func makeUseCaseVehiclesGetAll() -> Domain.UseCasesVehiclesPersistence {
        return UseCasesVehiclesPersistence(responseType: self.responseType, delay: self.delay)
    }

}
