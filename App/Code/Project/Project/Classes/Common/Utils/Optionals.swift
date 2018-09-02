import Foundation

func equalOptionals<T: Equatable>(_ lhs: T?, _ rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return lValue == rValue
    case (nil, nil):
        return true
    default:
        return false
    }
}

func equalOptionals<T: Equatable>(_ lhs: [T]?, _ rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return lValue == rValue
    case (nil, nil):
        return true
    default:
        return false
    }
}

func equalOptionals<K, V: Equatable>(_ lhs: [K: V]?, _ rhs: [K: V]?) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return lValue == rValue
    case (nil, nil):
        return true
    default:
        return false
    }
}

func == <K, V>(left: [K: V], right: [K: V]) -> Bool {
    return NSDictionary(dictionary: left).isEqual(to: right)
}

func == <K, V>(left: [K: V]?, right: [K: V]?) -> Bool {
    switch (left, right) {
    case let (lValue?, rValue?):
        return lValue == rValue
    case (nil, nil):
        return true
    default:
        return false
    }
}

func == <K, V>(left: [K: V?], right: [K: V?]) -> Bool {
    guard let left = left as? [K: V], let right = right as? [K: V] else { return false }
    return NSDictionary(dictionary: left).isEqual(to: right)
}

func nonOptional(_ value: String?, defaultValue: String = "") -> String {
    return value ?? defaultValue
}

func nonOptional(_ value: TimeInterval?, defaultValue: TimeInterval = 0) -> TimeInterval {
    return value ?? defaultValue
}

