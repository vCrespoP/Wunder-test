import Foundation

enum PersistenceConfigurationType {
    case map
    case list
}

extension PersistenceConfigurationType: AutoCases, AutoEquatableTRN, AutoHashableTRN { }
