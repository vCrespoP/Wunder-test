// Generated using Sourcery 0.11.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length

// MARK: - AutoHashableTRN

import SharedUtils

// MARK: - DataSourceConfigurationItem Hashable
extension DataSourceConfigurationItem: Hashable {

    internal var hashValue: Int {
        let strings: [String] = [
                    "\(type.hashValue)"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}


// MARK: - PersistenceConfigurationItem Hashable
extension PersistenceConfigurationItem: Hashable {

    internal var hashValue: Int {
        let strings: [String] = [
                    "\(type.hashValue)"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}




