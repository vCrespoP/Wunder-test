import Foundation

public extension Array {

    func split(_ accept: (Element) -> Bool) -> (Array, Array) {
        return self.reduce( ([Element](), [Element]()), { acc, item in
            var (accepted, rejected) = acc

            accept(item) ? accepted.append(item) : rejected.append(item)

            return (accepted, rejected)
        })
    }

}

