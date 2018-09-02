import Foundation

import NetworkKit
import NetworkSpecific
import Domain

import RxSwift

final class UseCasesVehiclesPersistence {

    // MARK: - Properties
    private let responseType: ResponseType
    private let delay: TimeInterval

    // MARK: - Life Cycle
    public init(responseType: ResponseType = .success(code: 200), delay: TimeInterval = 0.0) {
        self.responseType = responseType
        self.delay = delay
    }

}

extension UseCasesVehiclesPersistence: Domain.UseCasesVehiclesPersistence {

    public func store(vehicles: Vehicles, context: OperationContext) -> Observable<Vehicles> {
        switch self.responseType {
        case .success:
            return Observable
                .just(vehicles)
                .delaySubscription(RxTimeInterval(delay), scheduler: MainScheduler.instance)

        case .error(let code):
            let error = ErrorResponse(statusCode: code)
            return Observable
                .error(error)
                .delaySubscription(RxTimeInterval(delay), scheduler: MainScheduler.instance)
        }

    }

    func readAll(context: OperationContext) -> Observable<Vehicles> {
        switch self.responseType {
        case .success:
            return Observable
                .just([]) // Include if needed a better static response
                .delaySubscription(RxTimeInterval(delay), scheduler: MainScheduler.instance)

        case .error(let code):
            let error = ErrorResponse(statusCode: code)
            return Observable
                .error(error)
                .delaySubscription(RxTimeInterval(delay), scheduler: MainScheduler.instance)
        }

    }

}
