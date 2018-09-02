import Foundation

public struct ApiResponse<T: Codable>: Codable {

    public var data: T
    public var statusCode: Int? = 9999

    public init(object: T, statusCode: Int? = 9999) {
        self.data = object
        self.statusCode = statusCode
    }

}
