import Foundation

import Domain

import RxSwift

import PlatformPersistenceDisk
import PlatformPersistenceStatic

class PersistenceConfiguration {

    // MARK: Properties
    var items: Set<PersistenceConfigurationItem> = []

    // MARK: Life Cycle

}

// MARK: Public methods
extension PersistenceConfiguration {

    func getType(for type: PersistenceConfigurationType) -> Domain.UseCasePersistenceProvider {

        // In case it's missing
        let defaultProvider = self.persistenceProviderDisk

        let result = self.items.first(where: {
            $0.type == type
        })

        return result?.provider ?? defaultProvider

    }

    func changeConfiguration(for type: PersistenceConfigurationType, provider: Domain.UseCasePersistenceProvider) {
        let configurationItem = PersistenceConfigurationItem(type: type, provider: provider)
        self.items.update(with: configurationItem)
    }

    func changeAllConfiguration(to provider: Domain.UseCasePersistenceProvider) {
        PersistenceConfigurationType.allCases.forEach {
            self.changeConfiguration(for: $0, provider: provider)
        }
    }

}

extension PersistenceConfiguration {

    fileprivate var persistenceProviderDisk: Domain.UseCasePersistenceProvider {
        return PlatformPersistenceDisk.UseCasePersistenceProvider()
    }

    fileprivate var persistenceProviderPersistenceStaticSuccess: Domain.UseCasePersistenceProvider {
        return PlatformPersistenceStatic.UseCasePersistenceProvider(responseType: ResponseType.success(code: 200), delay: 0.5)
    }

    fileprivate var persistenceProviderPersistenceStaticError: Domain.UseCasePersistenceProvider {
        return PlatformPersistenceStatic.UseCasePersistenceProvider(responseType: ResponseType.error(code: 500), delay: 0.5)
    }

}

