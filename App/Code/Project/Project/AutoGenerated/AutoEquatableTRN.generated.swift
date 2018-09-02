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
// MARK: - DataSourceConfigurationItem AutoEquatableTRN
extension DataSourceConfigurationItem: Equatable {} 
internal func == (lhs: DataSourceConfigurationItem, rhs: DataSourceConfigurationItem) -> Bool {
    guard lhs.type == rhs.type else { return false }
    return true
}
// MARK: - PersistenceConfigurationItem AutoEquatableTRN
extension PersistenceConfigurationItem: Equatable {} 
internal func == (lhs: PersistenceConfigurationItem, rhs: PersistenceConfigurationItem) -> Bool {
    guard lhs.type == rhs.type else { return false }
    return true
}

// MARK: - AutoEquatableTRN for Enums
// MARK: - DataSourceType AutoEquatableTRN
extension DataSourceType: Equatable {}
internal func == (lhs: DataSourceType, rhs: DataSourceType) -> Bool {
    switch (lhs, rhs) {
         case (.map, .map): 
             return true 

         case (.list, .list): 
             return true 

        default: return false
    }
}
// MARK: - PersistenceConfigurationType AutoEquatableTRN
extension PersistenceConfigurationType: Equatable {}
internal func == (lhs: PersistenceConfigurationType, rhs: PersistenceConfigurationType) -> Bool {
    switch (lhs, rhs) {
         case (.map, .map): 
             return true 

         case (.list, .list): 
             return true 

        default: return false
    }
}

// MARK: -
