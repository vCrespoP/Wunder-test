import Foundation

public extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        return self.unique()
    }

    func unique() -> [Element] {
        var seen: [Element: Bool] = [:]
        return self.filter({ seen.updateValue(true, forKey: $0) == nil })
    }

    func subtract(takeAway: [Element]) -> [Element] {
        let set = Set(takeAway)
        return self.filter({ !set.contains($0) })
    }

    func intersect(with: [Element]) -> [Element] {
        let set = Set(with)
        return self.filter({ set.contains($0) })
    }
}

