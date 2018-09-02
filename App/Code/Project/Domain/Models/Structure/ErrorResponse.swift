import Foundation

public struct ErrorResponse: Error, Codable {

    public var statusCode: Int = 9999

    public init(statusCode: Int = 9999) {
        self.statusCode = statusCode
    }

}

extension ErrorResponse: AutoEquatableTRN, AutoHashableTRN { }

extension ErrorResponse {

    //    public static func from<T>(serverResponse: ApiResponse<T>?, statusCode: Int) -> ErrorResponse {
    //        return ErrorResponse(message: serverResponse?.message, statusCode: statusCode)
    //    }

    //    public func formatted() -> String {
    //        let title = message?.title ?? ""
    //        let text = message?.text ?? ""
    //        return "\(title) \(text) code: \(statusCode)"
    //    }
}
