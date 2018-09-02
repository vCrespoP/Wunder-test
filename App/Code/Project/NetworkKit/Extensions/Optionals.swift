import Foundation

fileprivate func combineHashValues(_ initial: Int, _ other: Int) -> Int {
    #if arch(x86_64) || arch(arm64)
    let magic: UInt = 0x9e3779b97f4a7c15
    #elseif arch(i386) || arch(arm)
    let magic: UInt = 0x9e3779b9
    #endif
    var lhs = UInt(bitPattern: initial)
    let rhs = UInt(bitPattern: other)
    lhs ^= rhs &+ magic &+ (lhs << 6) &+ (lhs >> 2)
    return Int(bitPattern: lhs)
}

fileprivate func hashDictionary<T: Hashable, U: Hashable>(_ dictionary: [T: U]?) -> Int {
    guard let dictionary = dictionary else {
        return 0
    }
    return dictionary.reduce(5381) {
        combineHashValues($0, combineHashValues($1.key.hashValue, $1.value.hashValue))
    }
}

extension Dictionary: Hashable where Key: Hashable, Value: Hashable {
    public var hashValue: Int {
        return hashDictionary(self)
    }
}
