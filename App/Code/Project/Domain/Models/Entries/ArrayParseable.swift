import Foundation

public protocol ArrayParseable {
    static func parseArray(fromDictionary jsonDict: [String: Any]) -> [Self]?
}
