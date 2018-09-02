import Foundation

import RxSwift

public protocol UseCasesVehiclesPersistence {
    func store(vehicles: Vehicles, context: OperationContext) -> Observable<Vehicles>
    func readAll(context: OperationContext) -> Observable<Vehicles>
}
