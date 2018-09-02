import Foundation

public protocol Numeric {
    init(_ v: Int)

    static func + (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Self) -> Self
    static func / (lhs: Self, rhs: Self) -> Self
    static var zero: Self { get }
    static var one: Self { get }
}

extension Int: Numeric {
    public static let zero = 0
    public static let one = 1
}

extension UInt: Numeric {
    public static let zero: UInt = 0
    public static let one: UInt = 1
}

extension Float: Numeric {
    public static let zero: Float = 0
    public static let one: Float = 1
}

extension Double: Numeric {
    public static let zero: Double = 0
    public static let one: Double = 1
}

// MARK: Specific byte length
extension Int8: Numeric {
    public static let zero: Int8 = 0
    public static let one: Int8 = 1
}

extension UInt8: Numeric {
    public static let zero: UInt8 = 0
    public static let one: UInt8 = 1
}

extension Int16: Numeric {
    public static let zero: Int16 = 0
    public static let one: Int16 = 1
}

extension UInt16: Numeric {
    public static let zero: UInt16 = 0
    public static let one: UInt16 = 1
}

extension Int32: Numeric {
    public static let zero: Int32 = 0
    public static let one: Int32 = 1
}

extension UInt32: Numeric {
    public static let zero: UInt32 = 0
    public static let one: UInt32 = 1
}

extension Int64: Numeric {
    public static let zero: Int64 = 0
    public static let one: Int64 = 1
}

extension UInt64: Numeric {
    public static let zero: UInt64 = 0
    public static let one: UInt64 = 1
}

//extension Float80: Numeric {
//	public static let zero: Float80 = 0
//	public static let one: Float80 = 1
//}

extension CGFloat: Numeric {
    public static let zero: CGFloat = 0
    public static let one: CGFloat = 1
}

