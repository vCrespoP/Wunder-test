import Foundation

public extension Logger {

    func verbose(_ messages: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        return self._log(messages, level: .verbose, filename: filename, line: line, column: column, funcName: funcName)
    }

    func debug(_ messages: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        return self._log(messages, level: .debug, filename: filename, line: line, column: column, funcName: funcName)
    }

    func info(_ messages: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        return self._log(messages, level: .info, filename: filename, line: line, column: column, funcName: funcName)
    }

    func warning(_ messages: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        return self._log(messages, level: .warning, filename: filename, line: line, column: column, funcName: funcName)
    }

    func error(_ messages: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        return self._log(messages, level: .error, filename: filename, line: line, column: column, funcName: funcName)
    }

    func critical(_ messages: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        return self._log(messages, level: .critical, filename: filename, line: line, column: column, funcName: funcName)
    }

}
