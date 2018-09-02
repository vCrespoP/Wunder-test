import Foundation

public extension Array where Element == Bool {
    var all: Bool {
        return self.reduce(true) { $0 && $1 }
    }

    var any: Bool {
        return self.reduce(false) { $0 || $1 }
    }

    var none: Bool {
        return self.reduce(false) { $0 && !$1 }
    }
}

public extension Array where Element: Numeric {
    var sum: Element {
        return self.reduce(Element.zero) { $0 + $1 }
    }

    var product: Element {
        return self.reduce(Element.one) { $0 * $1 }
    }

    var average: Element {
        return self.sum/Element(self.count)
    }
}

public extension Array where Element: Numeric, Element: Comparable {

    var median: Element? {
        guard self.count > 0 else { return nil }
        guard self.count > 1 else { return self.first }

        let sorted = self.sorted(by: <)

        let middle = sorted.count/2

        if self.count.isOdd {
            return sorted[middle]
        }
        else {
            return (sorted[middle-1] + sorted[middle])/Element(2)
        }
    }
}

// Note: max and min already exist in the standard library as functions

