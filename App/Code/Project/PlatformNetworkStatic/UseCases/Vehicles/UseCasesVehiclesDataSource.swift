import Foundation
import NetworkSpecific
import SharedUtils

import Domain
import RxSwift

final class UseCasesVehiclesDataSource {

    private let responseType: ResponseType
    private let delay: TimeInterval

    init(responseType: ResponseType, delay: TimeInterval) {
        self.responseType = responseType
        self.delay = delay
    }

}

extension UseCasesVehiclesDataSource: Domain.UseCasesVehiclesDataSource {

    public func getAll(context: OperationContext) -> Observable<SuccessResponse<Vehicles>> {

        switch self.responseType {
        case .success(let statusCode):

            let jsonName = "vehicles"
            let json = JSONUtils.readDictionary(resourceName: jsonName, bundle: Bundle(for: type(of: self)))

            let data = Vehicle.parseArray(fromDictionary: json!)
            let response = SuccessResponse(data: data!, statusCode: statusCode)

            return Observable
                .just(response)
                .delaySubscription(RxTimeInterval(delay), scheduler: MainScheduler.instance)

        case .error(let code):
            let error = ErrorResponse(statusCode: code)
            return Observable
                .error(error)
                .delaySubscription(RxTimeInterval(delay), scheduler: MainScheduler.instance)

        case .timeout(let seconds):
            let error = ErrorResponse(statusCode: 9999)
            return Observable
                .error(error)
                .delaySubscription(RxTimeInterval(seconds), scheduler: MainScheduler.instance)

        }

    }

}
