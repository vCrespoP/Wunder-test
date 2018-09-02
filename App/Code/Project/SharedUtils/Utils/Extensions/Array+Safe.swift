import Foundation

/// Use as array[safe:3]
public extension Array {

    subscript (safe index: Int) -> Element? {
        guard index >= 0 else { return nil }

        return self[safe: UInt(index)]
    }

    subscript (safe index: UInt) -> Element? {
        return Int(index) < count ? self[Int(index)] : nil
    }

}

