import Foundation

public func with<T>(_ constant: T, _ update: (inout T) throws ->() ) rethrows -> T {
    var variable = constant
    try update(&variable)
    return variable
}
