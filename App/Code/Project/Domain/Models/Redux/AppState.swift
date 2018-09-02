import Foundation

import ReSwift

public struct AppState: StateType {

    public var location: LocationState = LocationState.default

    public init() { }

    public static var `default`: AppState {
        return AppState()
    }

}

extension AppState: AutoEquatableTRN, AutoHashableTRN { }
