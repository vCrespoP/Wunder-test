import Foundation

import RxSwift

public protocol UseCasesVehiclesDataSource {
    func getAll(context: OperationContext) -> Observable<SuccessResponse<Vehicles>>
}
