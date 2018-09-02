// Generated using Sourcery 0.11.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length

fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}

// MARK: - AutoEquatableTRN for classes, protocols, structs
// MARK: - AppState AutoEquatableTRN
extension AppState: Equatable {} 
public func == (lhs: AppState, rhs: AppState) -> Bool {
    guard lhs.location == rhs.location else { return false }
    return true
}
// MARK: - ErrorResponse AutoEquatableTRN
extension ErrorResponse: Equatable {} 
public func == (lhs: ErrorResponse, rhs: ErrorResponse) -> Bool {
    guard lhs.statusCode == rhs.statusCode else { return false }
    return true
}
// MARK: - LocationState AutoEquatableTRN
extension LocationState: Equatable {} 
public func == (lhs: LocationState, rhs: LocationState) -> Bool {
    guard compareOptionals(lhs: lhs.lastLocation, rhs: rhs.lastLocation, compare: ==) else { return false }
    guard lhs.accuracy == rhs.accuracy else { return false }
    guard lhs.distanceFilter == rhs.distanceFilter else { return false }
    guard lhs.status == rhs.status else { return false }
    guard lhs.permissionStatus == rhs.permissionStatus else { return false }
    return true
}
// MARK: - OperationContext AutoEquatableTRN
extension OperationContext: Equatable {} 
public func == (lhs: OperationContext, rhs: OperationContext) -> Bool {
    return true
}
// MARK: - Vehicle AutoEquatableTRN
extension Vehicle: Equatable {} 
public func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
    guard compareOptionals(lhs: lhs.address, rhs: rhs.address, compare: ==) else { return false }
    guard lhs.coordinates == rhs.coordinates else { return false }
    guard compareOptionals(lhs: lhs.engineType, rhs: rhs.engineType, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.exterior, rhs: rhs.exterior, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.fuel, rhs: rhs.fuel, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.interior, rhs: rhs.interior, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.name, rhs: rhs.name, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.vin, rhs: rhs.vin, compare: ==) else { return false }
    return true
}

// MARK: - AutoEquatableTRN for Enums
// MARK: - PRError AutoEquatableTRN
extension PRError: Equatable {}
public func == (lhs: PRError, rhs: PRError) -> Bool {
    switch (lhs, rhs) {
         case (.unknown, .unknown): 
             return true 

         case (.parsing(let lhs), .parsing(let rhs)): 
                return lhs == rhs

        default: return false
    }
}

// MARK: -
