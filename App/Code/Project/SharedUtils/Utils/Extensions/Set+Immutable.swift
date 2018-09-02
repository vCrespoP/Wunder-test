import Foundation

public extension Set {
    func inserting(_ item: Element) -> Set {
        var set = self
        set.insert(item)
        return set
    }

    func removing(_ item: Element) -> Set {
        var set = self
        set.remove(item)
        return set
    }
}
