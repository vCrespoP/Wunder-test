import Foundation

public struct Vehicle: Codable {

    public var address: String?
    public var coordinates: [Double] = []
    public var engineType: EngineType?
    public var exterior: ConditionStatus?
    public var fuel: Int? // Percentage
    public var interior: ConditionStatus?
    public var name: String?
    public var vin: String?

    public init() { }
}

extension Vehicle: AutoEquatableTRN, AutoHashableTRN { }

import CoreLocation
import UIKit

// MARK: Public methods
public extension Vehicle {

    static func parseArray(fromDictionary jsonDict: [String: Any], key: String = "placemarks") -> Vehicles? {
        return Domain.parse(fromDictionary: jsonDict, key: key)
    }

    var nameFormatted: String {
        return self.stringValueOrDefault(for: self.name)
    }

    var address1Formatted: String {
        let component = self.address?
            .split(separator: ",")
            .first?
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return self.stringValueOrDefault(for: component)
    }

    var address2Formatted: String {
        let component = self.address?
            .split(separator: ",")
            .last?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return self.stringValueOrDefault(for: component)
    }

    var fuelFormatted: String {
        return self.stringValueOrDefault(for: self.fuel) + "%"
    }

    var vinFormatted: String {
        return self.stringValueOrDefault(for: self.vin) + "%"
    }

    func distance(from location: CLLocation) -> Double? {
        guard let itemCoordinates = self.coreLocationCoordinate else {
            return nil
        }
        let itemLocation = CLLocation(latitude: itemCoordinates.latitude, longitude: itemCoordinates.longitude)
        let result = itemLocation.distance(from: location)
        return result
    }

    func distanceFormatted(from location: CLLocation) -> String {
        let distance = self.distance(from: location)
        return self.stringDistanceValueOrDefault(for: distance)
    }

    var coreLocationCoordinate: CLLocationCoordinate2D? {
        guard self.coordinates.count == 3 else {
            return nil
        }
        let lat = self.coordinates[1]
        let lon = self.coordinates[0]
        //        let altitude = self.coordinates[2]
        let result = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        return result
    }

    var annotationImagePercentage: UIImage? {
        guard let charge = self.fuel else {
            return nil
        }

        let decimalCharge: Int
        switch charge % 10 {
        case 0, 1, 2: decimalCharge = 0
        case 3, 4, 5, 6, 7: decimalCharge = 5
        case 8, 9: decimalCharge = 10

        default:
            decimalCharge = 0
        }
        let roundedCharge = (charge / 10 * 10) + decimalCharge
        let imageName = "VehicleCharge" + "\(roundedCharge)"
        let result = UIImage(named: imageName)
        return result
    }
    
    var annotationImage: UIImage? {
        guard let charge = self.fuel else {
            return nil
        }
        let result: UIImage?
        if charge < 30 {
            result = UIImage(named: "pointer-red")
        } else if charge < 55 {
            result = UIImage(named: "pointer-yellow")
        } else {
            result = UIImage(named: "pointer-green")
        }
        return result
    }

    var interiorColor: UIColor {
        guard let interior = self.interior else {
            return UIColor.black
        }
        switch interior {
        case .good:
            return UIColor(hex: 0x55D54B)
        case .unacceptable:
            return UIColor(hex: 0xE4193E)
        }
    }

    var exteriorColor: UIColor {
        guard let exterior = self.exterior else {
            return UIColor.black
        }
        switch exterior {
        case .good:
            return UIColor(hex: 0x55D54B)
        case .unacceptable:
            return UIColor(hex: 0xE4193E)
        }
    }

}

// MARK: private methods
private extension Vehicle {

    func stringValueOrDefault(for item: Any?) -> String {
        guard let item = item else {
            return "?"
        }
        return "\(item)"
    }

    func stringDistanceValueOrDefault(for item: Double?) -> String {
        guard let item = item else {
            return "?"
        }
        let result = Utils.formatDistance(meters: item)
        return result
    }

}

