import Foundation

public enum RequestUrl {
    case endpoint(String)
    case full(URL)
}

extension RequestUrl: AutoCases, AutoEquatableTRN, AutoHashableTRN { }
