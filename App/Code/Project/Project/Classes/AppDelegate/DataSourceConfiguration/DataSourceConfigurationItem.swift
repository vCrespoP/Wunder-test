import Foundation

import Domain

/// Tuple of type and associated provider
struct DataSourceConfigurationItem {
    var type: DataSourceType
    // sourcery: skipDescription
    var provider: Domain.UseCaseDataSourceProvider
}

extension DataSourceConfigurationItem: AutoEquatableTRN, AutoHashableTRN { }
