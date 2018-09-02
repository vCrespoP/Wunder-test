import Foundation

import NetworkKit
import NetworkSpecific
import Domain

import RxSwift

final class UseCasesVehiclesPersistence {

    // MARK: - Properties

    // MARK: - Life Cycle
    public init() { }

}

extension UseCasesVehiclesPersistence: Domain.UseCasesVehiclesPersistence {

    func store(vehicles: Vehicles, context: OperationContext) -> Observable<Vehicles> {
        let json = vehicles.toJson()
        UserDefaults.standard.set(json, forKey: "vehiclesGetAll")
        return Observable.just(vehicles)
    }

    func readAll(context: OperationContext) -> Observable<Vehicles> {

        guard let decoded = UserDefaults.standard.object(forKey: "vehiclesGetAll") else {
            let error = PRError.parsing(message: "No vehicles found")
            return Observable.error(error)
        }
        do {
            guard let result = try Vehicles.parse(from: decoded) else {
                let error = PRError.parsing(message: "Vehicles corrupted")
                return Observable.error(error)
            }
            return Observable.just(result)
        }
        catch {
            let error = PRError.parsing(message: "Vehicles corrupted")
            return Observable.error(error)
        }

    }

}
