import Foundation

/// Possibilities for different datasource types
enum DataSourceType {
    case map
    case list
}

extension DataSourceType: AutoCases, AutoEquatableTRN, AutoHashableTRN { }
