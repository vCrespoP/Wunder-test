import Foundation
import Domain
import NetworkKit
import NetworkKitAlamofire

public enum ApiEnvironment: String {
    case debug = "Debug"
    case integration = "Integration"
    case demo = "Demo"
    case production = "Production"
}

public class UseCaseDataSourceProvider {

    // MARK: - Properties
    private let networkService: NetworkService

    // MARK: - Life Cycle
    public init(environment: ApiEnvironment) {
        let baseUrl: URL
        switch environment {
        case .debug:
            baseUrl = URL(string: "http://192.168.0.1")!
        case .integration:
            baseUrl = URL(string: "https://s3-us-west-2.amazonaws.com/wunderbucket")!
        case .demo:
            baseUrl = URL(string: "https://s3-us-west-2.amazonaws.com/wunderbucket")!
        case .production:
            baseUrl = URL(string: "https://s3-us-west-2.amazonaws.com/wunderbucket")!
        }

        self.networkService = AlamofireService(baseUrl: baseUrl)
    }

}

extension UseCaseDataSourceProvider: Domain.UseCaseDataSourceProvider {

    // MARK: Vehicles
    public func makeUseCaseVehiclesGetAll() -> Domain.UseCasesVehiclesDataSource {
        return UseCasesVehiclesDataSource(networkService: self.networkService)
    }

}
