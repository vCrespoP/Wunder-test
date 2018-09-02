import Foundation

public extension Dictionary {
    var jsonString: String? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        return jsonData.flatMap { String(data: $0, encoding: .utf8) }
    }
}
