import Foundation

public enum LogLevel: Int {
    case verbose = 1
    case debug
    case info
    case warning
    case error
    case critical
    case none
}

extension LogLevel: Hashable {

    public var hashValue: Int {
        return self.rawValue
    }

}
