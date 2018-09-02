import Foundation

public protocol OptionalType {
    associatedtype T
    func intoOptional() -> T?
}

extension Optional: OptionalType {
    public func intoOptional() -> Wrapped? {
        return self.flatMap {$0}
    }
}

public extension Dictionary where Value: OptionalType {
    func compact() -> [Key: Value.T] {
        var dic = [Key: Value.T]()
        for (key, value) in self {
            if let optional = value.intoOptional() {
                dic[key] = optional
            }
            else {
                dic.removeValue(forKey: key)
            }
        }
        return dic
    }
}

public extension Dictionary {

    mutating func update(other: Dictionary) {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
        }
    }

}
