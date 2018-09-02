import Foundation

public struct TypeUtils {

}

// MARK: Public Methods
public extension TypeUtils {

    static func name(_ thing: Any) -> String {
        return String(describing: thing.self)
    }

}

