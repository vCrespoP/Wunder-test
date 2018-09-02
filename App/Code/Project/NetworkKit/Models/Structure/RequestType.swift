import Foundation
import SharedUtils

public enum RequestType {
    case request(parameters: [String: AnyHashable]?, parametersEncoding: ParametersEncoding)
    case uploadMultipartData(parameters: [String: MultipartParameter])

    public static var `default`: RequestType {
        return .request(parameters: nil, parametersEncoding: .url)
    }
}

// MARK: Equatable
extension RequestType: Equatable {
    static public func == (left: RequestType, right: RequestType) -> Bool {
        switch (left, right) {
        case (.request(let p1, let e1), .request(let p2, let e2)):
            return p1 == p2 && e1 == e2
        case (.uploadMultipartData(let p1), .uploadMultipartData(let p2)):
            return p1 == p2
        default:
            return false
        }
    }
}

// MARK: Hashable
extension RequestType {
    public var hashValue: Int {
        switch self {
        case .request(let params, let encoding):
            let paramsHash = params?.hashValue ?? 0

            return "request \(paramsHash) \(encoding.hashValue)".hashValue
        case .uploadMultipartData(let params):
            return "uploadMultipart \(params.hashValue)".hashValue
        }
    }
}

