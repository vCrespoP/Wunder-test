import Foundation

public struct OperationContext {

    // sourcery: skipDescription
    public var logger: Logger

    public init(logger: Logger = ConsoleLogger.default) {
        self.logger = logger
    }

}

extension OperationContext: AutoEquatableTRN, AutoHashableTRN { }

