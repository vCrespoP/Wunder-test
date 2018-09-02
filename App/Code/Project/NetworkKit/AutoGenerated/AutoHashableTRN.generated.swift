// Generated using Sourcery 0.11.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length

// MARK: - AutoHashableTRN

import SharedUtils

// MARK: - HTTPResponse Hashable
extension HTTPResponse: Hashable {

    public var hashValue: Int {
        let strings: [String] = [
                    "\(responseCode.hashValue)",
                    "\(String(describing: data?.hashValue))",
                    "\(url.hashValue)",
                    "\(String(describing: headerFields?.hashValue))"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}


// MARK: - MultipartFileParameter Hashable
extension MultipartFileParameter: Hashable {

    public var hashValue: Int {
        let strings: [String] = [
                    "\(mimeType.hashValue)",
                    "\(String(describing: fileName?.hashValue))"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}


// MARK: - MultipartParameter Hashable
extension MultipartParameter: Hashable {

    public var hashValue: Int {
        let strings: [String] = [
                    "\(data.hashValue)",
                    "\(String(describing: fileParameter?.hashValue))"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}




