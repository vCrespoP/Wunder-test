// Generated using Sourcery 0.11.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length

// MARK: - AutoHashableTRN

import SharedUtils

// MARK: - AppState Hashable
extension AppState: Hashable {

    public var hashValue: Int {
        let strings: [String] = [
                    "\(location.hashValue)"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}


// MARK: - ErrorResponse Hashable
extension ErrorResponse: Hashable {

    public var hashValue: Int {
        let strings: [String] = [
                    "\(statusCode.hashValue)"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}


// MARK: - LocationState Hashable
extension LocationState: Hashable {

    public var hashValue: Int {
        let strings: [String] = [
                    "\(String(describing: lastLocation?.hashValue))",
                    "\(accuracy.hashValue)",
                    "\(distanceFilter.hashValue)",
                    "\(status.hashValue)",
                    "\(permissionStatus.hashValue)"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}


// MARK: - OperationContext Hashable
extension OperationContext: Hashable {

    public var hashValue: Int {
        let strings: [String] = [
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}


// MARK: - Vehicle Hashable
extension Vehicle: Hashable {

    public var hashValue: Int {
        let strings: [String] = [
                    "\(String(describing: address?.hashValue))",
                    "\(coordinates.hashValue)",
                    "\(String(describing: engineType?.hashValue))",
                    "\(String(describing: exterior?.hashValue))",
                    "\(String(describing: fuel?.hashValue))",
                    "\(String(describing: interior?.hashValue))",
                    "\(String(describing: name?.hashValue))",
                    "\(String(describing: vin?.hashValue))"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}




