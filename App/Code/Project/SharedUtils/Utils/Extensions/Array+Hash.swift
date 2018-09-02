import Foundation

// http://stackoverflow.com/a/31444592
// TODO: Make array conform to hashable when swift supports it
public extension Array where Element: Hashable {

    var hashValue: Int {
        let result = self.reduce(5381) {
            ($0 << 5) &+ $0 &+ $1.hashValue
        }
        return result
    }

}
