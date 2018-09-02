import Foundation

import NetworkKit
import NetworkSpecific
import Domain

import RxSwift

final class UseCasesVehiclesDataSource {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

}

extension UseCasesVehiclesDataSource: Domain.UseCasesVehiclesDataSource {

    func getAll(context: OperationContext) -> Observable<SuccessResponse<Vehicles>> {
        let request = VehicleGetAllRequest.apiRequest(context: context)

        let response: Observable<SuccessResponse<VehiclesResponse>> =
            ApiUtils.apiRequest(networkService: networkService, request: request, logger: context.logger)

        // Transform into an array of Vehicle
        let result = response.flatMap { responseVehicles -> Observable<SuccessResponse<Vehicles>> in
            let vehicles = responseVehicles.data?.placemarks
            let statusCode = responseVehicles.statusCode
            let newResponse = SuccessResponse(data: vehicles, statusCode: statusCode)
            return Observable.just(newResponse)
        }

        return result
    }

}
