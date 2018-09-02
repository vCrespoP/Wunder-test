import Foundation

public enum ResponseError: Error {
    case serialization(Error)
    case network(Error)
}
