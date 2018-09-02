import Foundation

public protocol Logger {

    // swiftlint:disable:next function_parameter_count
    func log(_ messages: Any..., level: LogLevel, filename: String, line: Int, column: Int, funcName: String)
    // swiftlint:disable:next function_parameter_count
    func _log(_ message: [Any], level: LogLevel, filename: String, line: Int, column: Int, funcName: String)
    func change(logLevel: LogLevel)

}
