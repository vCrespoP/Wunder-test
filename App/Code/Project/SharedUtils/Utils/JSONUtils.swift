import Foundation

public struct JSONUtils {

}

// MARK: Public Methods
public extension JSONUtils {

    // MARK: Content
    static func read(content: String) -> Any? {
        guard let contentData = content.data(using: .utf8) else { return nil }

        return try? JSONSerialization.jsonObject(with: contentData, options: [ ])
    }

    static func readDictionary(content: String) -> [String: Any]? {
        return read(content: content) as? [String: Any]
    }

    static func readArray(content: String) -> [[String: Any]]? {
        return read(content: content) as? [[String: Any]]
    }

    // MARK: Resource
    static func read(resourceName: String, bundle: Bundle = Bundle.main) -> Any? {
        guard let content = bundle.read(resourceName: resourceName, extension: "json") else { return nil }

        return read(content: content)
    }

    static func readDictionary(resourceName: String, bundle: Bundle = Bundle.main) -> [String: Any]? {
        return read(resourceName: resourceName, bundle: bundle) as? [String: Any]
    }

    static func readDictionaryData(resourceName: String, bundle: Bundle = Bundle.main) -> [String: Any]? {
        guard let jsonDict = self.readDictionary(resourceName: resourceName, bundle: bundle) else {
            return nil
        }

        guard let jsonData = jsonDict["data"] as? [String: Any] else {
            return nil
        }
        return jsonData
    }

    static func readArray(resourceName: String, bundle: Bundle = Bundle.main) -> [[String: Any]]? {
        return read(resourceName: resourceName, bundle: bundle) as? [[String: Any]]
    }

}

