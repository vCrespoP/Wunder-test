import Foundation

public extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }

    var isOdd: Bool {
        return !isEven
    }
}

