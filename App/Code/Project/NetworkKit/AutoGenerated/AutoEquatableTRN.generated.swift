// Generated using Sourcery 0.11.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length

fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}

// MARK: - AutoEquatableTRN for classes, protocols, structs
// MARK: - HTTPResponse AutoEquatableTRN
extension HTTPResponse: Equatable {} 
public func == (lhs: HTTPResponse, rhs: HTTPResponse) -> Bool {
    guard lhs.responseCode == rhs.responseCode else { return false }
    guard compareOptionals(lhs: lhs.data, rhs: rhs.data, compare: ==) else { return false }
    guard lhs.url == rhs.url else { return false }
    guard compareOptionals(lhs: lhs.headerFields, rhs: rhs.headerFields, compare: ==) else { return false }
    return true
}
// MARK: - MultipartFileParameter AutoEquatableTRN
extension MultipartFileParameter: Equatable {} 
public func == (lhs: MultipartFileParameter, rhs: MultipartFileParameter) -> Bool {
    guard lhs.mimeType == rhs.mimeType else { return false }
    guard compareOptionals(lhs: lhs.fileName, rhs: rhs.fileName, compare: ==) else { return false }
    return true
}
// MARK: - MultipartParameter AutoEquatableTRN
extension MultipartParameter: Equatable {} 
public func == (lhs: MultipartParameter, rhs: MultipartParameter) -> Bool {
    guard lhs.data == rhs.data else { return false }
    guard compareOptionals(lhs: lhs.fileParameter, rhs: rhs.fileParameter, compare: ==) else { return false }
    return true
}

// MARK: - AutoEquatableTRN for Enums
// MARK: - HTTPMethod AutoEquatableTRN
extension HTTPMethod: Equatable {}
public func == (lhs: HTTPMethod, rhs: HTTPMethod) -> Bool {
    switch (lhs, rhs) {
         case (.get, .get): 
             return true 

         case (.post, .post): 
             return true 

         case (.put, .put): 
             return true 

         case (.delete, .delete): 
             return true 

        default: return false
    }
}
// MARK: - RequestUrl AutoEquatableTRN
extension RequestUrl: Equatable {}
public func == (lhs: RequestUrl, rhs: RequestUrl) -> Bool {
    switch (lhs, rhs) {
         case (.endpoint(let lhs), .endpoint(let rhs)): 
                return lhs == rhs

         case (.full(let lhs), .full(let rhs)): 
                return lhs == rhs

        default: return false
    }
}

// MARK: -
