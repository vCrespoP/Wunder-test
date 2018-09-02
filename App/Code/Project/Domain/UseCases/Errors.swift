import Foundation

public enum PRError: Error {
    case unknown

    // Network
    case parsing(message: String)

}

extension PRError: AutoCases, AutoEquatableTRN, AutoHashableTRN2 { }
