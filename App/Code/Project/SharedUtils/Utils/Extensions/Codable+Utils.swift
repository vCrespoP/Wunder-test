import Foundation

// MARK: Decodable
public extension Decodable {

    static func parse(resourceName: String, bundle: Bundle = Bundle.main) throws -> Self? {
        return try bundle
            .url(forResource: resourceName, withExtension: "json")
            .flatMap {
                return try? Data(contentsOf: $0)
            }
            .flatMap { data in
                return try Self.parse(from: data)
        }
    }

    static func parse(from item: Any?) throws -> Self? {
        return try self.data(from: item)
            .flatMap { data in
                return try JSONDecoder().decode(Self.self, from: data)
        }
    }

    public static func data(from item: Any?) -> Data? {
        switch item {
        case let data as Data:
            return data
        case let string as String:
            return string.data(using: .utf8)
        case .some(let item):
            return try? JSONSerialization.data(withJSONObject: item, options: [])
        case nil:
            return nil
        }
    }

}

// MARK: Encodable
public extension Encodable {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }

    func toJson() -> [String: AnyHashable] {
        return self.toData()
            .flatMap {
                return try? JSONSerialization.jsonObject(with: $0, options: [])
            }
            .flatMap { $0 as? [String: AnyHashable] } ?? [:]
    }

    func toJsonString() -> String? {
        guard let jsonData = self.toData() else {
            return nil
        }
        let result = String(data: jsonData, encoding: .utf8)
        return result
    }

}

public extension Array where Element: Encodable {

    func toJson() -> [[String: AnyHashable]] {
        return self.toData()
            .flatMap {
                return try? JSONSerialization.jsonObject(with: $0, options: [])
            }
            .flatMap { $0 as? [[String: AnyHashable]] } ?? []
    }

}
