import Foundation

public func parse<T: Codable>(fromDictionary jsonDict: [String: Any], key: String) -> [T]? {
    guard let jsonDataItems = jsonDict[key] as? [[String: Any]] else {
        return nil
    }

    let result: [T] = jsonDataItems.compactMap {
        let data = try? JSONSerialization.data(withJSONObject: $0, options: [])
        return data
            .flatMap { (data: Data) -> T? in
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                }
                catch let error {
                    print(error)
                    return nil
                }
        }
    }
    return result
}
