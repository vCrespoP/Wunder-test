import Foundation

public extension String {

    subscript(value: PartialRangeUpTo<Int>) -> String {
        return String(self[value])
    }

    subscript(value: PartialRangeThrough<Int>) -> String {
        return String(self[value])
    }

    subscript(value: PartialRangeFrom<Int>) -> String {
        return String(self[value])
    }

}

public extension String {

    subscript(value: PartialRangeUpTo<Int>) -> String.SubSequence {
        return self[..<index(startIndex, offsetBy: value.upperBound)]
    }

    subscript(value: PartialRangeThrough<Int>) -> String.SubSequence {
        return self[...index(startIndex, offsetBy: value.upperBound)]
    }

    subscript(value: PartialRangeFrom<Int>) -> String.SubSequence {
        return self[index(startIndex, offsetBy: value.lowerBound)...]
    }

}

