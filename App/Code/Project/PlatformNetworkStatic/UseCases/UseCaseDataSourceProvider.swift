import Foundation

import Domain

public final class UseCaseDataSourceProvider {

    // MARK: - Properties
    private let responseType: ResponseType
    private let delay: TimeInterval

    // MARK: - Life Cycle
    public init(responseType: ResponseType = .success(code: 200), delay: TimeInterval = 0.0) {
        self.responseType = responseType
        self.delay = delay
    }

}

extension UseCaseDataSourceProvider: Domain.UseCaseDataSourceProvider {

    public func makeUseCaseVehiclesGetAll() -> Domain.UseCasesVehiclesDataSource {
        return UseCasesVehiclesDataSource(responseType: self.responseType, delay: self.delay)
    }
}
