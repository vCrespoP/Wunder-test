import Foundation

import Domain

import RxSwift

import PlatformNetworkApi
import PlatformNetworkStatic

/// Configures a DataSource, that fetches data
class DataSourceConfiguration {

    // MARK: Properties

    /// API stage [Dev|Staging|Production]
    var environment: ApiEnvironment {
        didSet {
            self.changeAllConfiguration(environment: environment)
        }
    }

    /// DataSource items, configured separatedly so they can be changed
    // in runtime, dynamically (static responses vs api responses and stage)
    var items: Set<DataSourceConfigurationItem> = []

    // MARK: Life Cycle
    init() {
        self.environment = DataSourceConfiguration.defaultEnvironment
    }

}

// MARK: Public methods
extension DataSourceConfiguration {

    /// Calculates default environment depending on the compilation/flags
    private static var defaultEnvironment: ApiEnvironment {
        #if CONFIGURATION_Release
        return .production
        #elseif CONFIGURATION_Demo
        return .demo
        #elseif CONFIGURATION_Debug
        return .integration
        #else
        return .production
        #endif
    }

    /// Get the type for a concrete item
    func getType(for type: DataSourceType) -> Domain.UseCaseDataSourceProvider {

        // In case it's missing
        let defaultProvider = self.dataSourceProviderNetworkApi(environment: self.environment)

        let result = self.items.first(where: {
            $0.type == type
        })

        return result?.provider ?? defaultProvider
    }

    /// Change a single configuration
    func changeConfiguration(for type: DataSourceType, provider: Domain.UseCaseDataSourceProvider) {
        let dataSourceConfigurationItem = DataSourceConfigurationItem(type: type, provider: provider)
        self.items.update(with: dataSourceConfigurationItem)
    }

    /// Change all configurations to a specified provider
    func changeAllConfiguration(to provider: Domain.UseCaseDataSourceProvider) {
        DataSourceType.allCases.forEach {
            self.changeConfiguration(for: $0, provider: provider)
        }
    }

    /// Change all configurations to a specified environment
    func changeAllConfiguration(environment: ApiEnvironment, debug: Bool = false) {
        let provider = PlatformNetworkApi.UseCaseDataSourceProvider(environment: environment)
        self.changeAllConfiguration(to: provider)
    }

}

// MARK: Private methods
extension DataSourceConfiguration {

    // Datasources

    /// API
    fileprivate func dataSourceProviderNetworkApi(environment: ApiEnvironment) -> Domain.UseCaseDataSourceProvider {
        return PlatformNetworkApi.UseCaseDataSourceProvider(environment: environment)
    }

    /// Static Success
    fileprivate var dataSourceProviderNetworkStaticSuccess: Domain.UseCaseDataSourceProvider {
        return PlatformNetworkStatic.UseCaseDataSourceProvider(responseType: ResponseType.success(code: 200), delay: 1)
    }

    /// Static Error
    fileprivate var dataSourceProviderNetworkStaticError: Domain.UseCaseDataSourceProvider {
        return PlatformNetworkStatic.UseCaseDataSourceProvider(responseType: ResponseType.error(code: 500), delay: 1)
    }

    /// Static Timeout
    fileprivate var dataSourceProviderNetworkStaticTimeOut: Domain.UseCaseDataSourceProvider {
        return PlatformNetworkStatic.UseCaseDataSourceProvider(responseType: ResponseType.timeout(seconds: 1), delay: 2)
    }

}
