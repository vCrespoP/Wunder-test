import Foundation

public extension Array where Element == String? {

    func joined(separator: String = "") -> String {
        let result = self
            .compactMap {
                return $0
            }
            .joined(separator: separator)
        return result
    }

}
