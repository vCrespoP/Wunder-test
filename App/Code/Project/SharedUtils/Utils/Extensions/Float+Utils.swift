import Foundation

public extension Float {
    func format(_ decimals: Int) -> String {
        let format = String(decimals)
        return String(format: "%.\(format)f", self)
    }
}
