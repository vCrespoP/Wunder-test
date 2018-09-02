import Foundation

public struct DataResponse<T: Codable>: Codable {
    public var data: T?

    public init() { }
}
