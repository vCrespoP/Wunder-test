import Foundation

public struct ErrorResponse: Error {

    public var message: String?
    public var statusCode: Int = 9999

    public init() { }

    public init(message: String?, statusCode: Int = 9999) {
        self.message = message
        self.statusCode = statusCode
    }

}

extension ErrorResponse: AutoEquatableTRN, AutoHashableTRN { }

