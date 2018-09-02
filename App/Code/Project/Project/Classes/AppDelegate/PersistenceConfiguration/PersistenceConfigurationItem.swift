import Foundation

import Domain

struct PersistenceConfigurationItem {
    var type: PersistenceConfigurationType
    // sourcery: skipDescription
    var provider: Domain.UseCasePersistenceProvider
}

extension PersistenceConfigurationItem: AutoEquatableTRN, AutoHashableTRN { }
