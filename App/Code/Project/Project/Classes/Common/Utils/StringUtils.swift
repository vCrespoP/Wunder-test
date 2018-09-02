import Foundation

extension String {
    public func truncated(_ length: Int, trailing: String = "…") -> String {
        return Project.truncated(self, length: length, trailing: trailing)
    }
}

public func truncated(_ string: String, length: Int, trailing: String = "…") -> String {
    return (string.count > length) ? String(string.prefix(length)) + trailing : string
}
