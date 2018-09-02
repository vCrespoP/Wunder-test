import Foundation

import SharedUtils

public struct SuccessResponse<T: Codable> {

    public var data: T?
    public var statusCode: Int?

    public init(data: T?, statusCode: Int? = nil) {
        self.data = data
        self.statusCode = statusCode
    }

}
