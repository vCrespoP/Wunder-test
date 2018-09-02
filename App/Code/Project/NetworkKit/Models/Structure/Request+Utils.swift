import Foundation

public extension Request {
    public func description(_ baseUrl: URL) -> String {
        let url = fullUrl(baseUrl: baseUrl)
        return [
            "method: \(method)",
            "url: \(url)",
            "type: \(type)",
            "timeout: \(timeout)",
            "headers: \(headers?.description ?? "")",
            "successCodes: \(successCodes)"
            ].joined(separator: "\n")
    }
}
