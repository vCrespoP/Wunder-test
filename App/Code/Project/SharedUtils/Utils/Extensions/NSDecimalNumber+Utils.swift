import Foundation

public extension NSDecimalNumber {
    func absNumber() -> NSDecimalNumber {

        guard self.compare(NSDecimalNumber.zero) == .orderedAscending else {
            return self
        }

        let negativeOne = NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true)
        return self.multiplying(by: negativeOne)
    }

    func rounded() -> NSDecimalNumber {
        let behavior = NSDecimalNumberHandler(roundingMode: .down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)

        return self.rounding(accordingToBehavior: behavior)
    }

    func decimals() -> NSDecimalNumber {
        return self.subtracting(self.rounded())
    }

    func isZero() -> Bool {
        return self.compare(NSDecimalNumber.zero) == .orderedSame
    }
}
