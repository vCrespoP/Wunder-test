import Foundation

public typealias Vehicles = [Vehicle]

import CoreLocation
public extension Array where Element == Vehicle {

    func sortedByDistance(from location: CLLocation?) -> Vehicles {
        guard let location = location else {
            return self
        }

        let result = self.sorted(by: { (item1: Vehicle, item2: Vehicle) -> Bool in
            return item1.distance(from: location) ?? 0 < item2.distance(from: location) ?? 0
        })

        return result
    }

}
