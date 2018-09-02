import Foundation

public func joined(_ components: [String?], separator: String = "\n") -> String {
    return components
        .compactMap {
            return $0
        }
        .filter {
            return !isBlank($0)
        }
        .joined(separator: separator)
}

public func isBlank(_ string: String?) -> Bool {
    guard let string = string else { return true }

    return trimmed(string).count == 0
}

public func trimmed(_ string: String) -> String {
    return string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
}

public func truncated(_ string: String, _ length: Int, trailing: String = "…") -> String {
    return (string.count > length) ? String(string.prefix(length)) + trailing : string
}
