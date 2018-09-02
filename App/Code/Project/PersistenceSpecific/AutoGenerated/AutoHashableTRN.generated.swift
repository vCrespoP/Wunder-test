// Generated using Sourcery 0.11.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length

// MARK: - AutoHashableTRN

import SharedUtils

// MARK: - ErrorResponse Hashable
extension ErrorResponse: Hashable {

    public var hashValue: Int {
        let strings: [String] = [
                    "\(String(describing: message?.hashValue))",
                    "\(statusCode.hashValue)"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}




