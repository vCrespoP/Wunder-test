import Foundation

public class ConsoleLogger {

    private let queue = DispatchQueue(label: "TRN.log")
    private var level: LogLevel

    private var history: CircularArray<LogMessage>

    public required init(level: LogLevel = .verbose, maxEntries: Int = 100) {
        self.level = level
        self.history = CircularArray(maxEntries: maxEntries)
    }

}

extension ConsoleLogger: Logger {

    public func log(_ message: Any..., level: LogLevel, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        return self._log(message, level: .verbose, filename: filename, line: line, column: column, funcName: funcName)
    }

    public func _log(_ message: [Any], level: LogLevel, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {

        // Do not log events we don't want by level
        guard level.rawValue >= self.level.rawValue else {
            return
        }

        let messagesJoined: String = self.format(message)

        let logMessage = LogMessage(emoji: level.emoji, date: Date(), message: messagesJoined, level: level, filename: filename, line: line, column: column, funcName: funcName)

        self.history.append(logMessage)

        let logMessageString = logMessage.formattedString

        queue.async {
            Swift.print(logMessageString)
        }

    }

    public func change(logLevel: LogLevel) {
        self.level = logLevel
    }

}

public extension ConsoleLogger {

    public static var `default`: ConsoleLogger {
        return self.init(level: .verbose)
    }

}

fileprivate extension ConsoleLogger {

    func format(_ messages: [Any]) -> String {
        let result = messages
            .map {
                return String(describing: $0)
            }
            .joined(separator: " ")
        return result

    }

}

fileprivate extension LogLevel {

    var emoji: String {
        switch self {
        case .verbose:
            return "🗣"
        case .debug:
            return "🔎"
        case .info:
            return "💬"
        case .warning:
            return "⚠️"
        case .error:
            return "⛔️"
        case .critical:
            return "💥"
        case .none:
            return ""
        }
    }

}
