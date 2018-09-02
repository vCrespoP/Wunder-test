import Foundation

public enum NetworkResponse<T> {
    case success(T, HTTPResponse)
    case networkError(ResponseError, HTTPResponse)
    case encodingError(Error)
}
