import Foundation

public class EmptyLogger {

    public init() { }

}

extension EmptyLogger: Logger {

    public func log(_ message: Any..., level: LogLevel, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {

    }
    public func _log(_ message: [Any], level: LogLevel, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {

    }

    public func change(logLevel: LogLevel) {

    }

}
