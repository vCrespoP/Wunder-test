import Foundation

public struct Request {
    public var method: HTTPMethod
    public var url: RequestUrl
    public var type: RequestType
    public var timeout: TimeInterval
    public var headers: [String: String]?
    public var successCodes: Range<Int>

    public init(
        method: HTTPMethod = .get,
        url: RequestUrl,
        type: RequestType = RequestType.default,
        timeout: TimeInterval = 50,
        headers: [String: String]? = nil,
        successCodes: Range<Int> = 200 ..< 300) {
        self.method = method
        self.url = url
        self.type = type
        self.timeout = timeout
        self.headers = headers
        self.successCodes = successCodes
    }

}

extension Request {
    public func fullUrl(baseUrl: URL) -> URL {
        switch self.url {
        case .endpoint(let endpoint):
            return baseUrl.appendingPathComponent(endpoint)
        case .full(let full):
            return full
        }
    }
}
