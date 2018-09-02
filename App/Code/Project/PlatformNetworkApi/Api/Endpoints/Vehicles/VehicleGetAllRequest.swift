import Foundation
import Domain
import NetworkKit

public enum VehicleGetAllRequest {

    public static func apiRequest(context: OperationContext) -> Request {

        let parameters: [String: AnyHashable] = [:]

        let headers: [String: String]? = context.commonHeaders

        let result = Request(
            method: .get,
            url: .endpoint("locations.json"),
            type: .request(parameters: parameters, parametersEncoding: .url),
            headers: headers)

        return result

    }

}

