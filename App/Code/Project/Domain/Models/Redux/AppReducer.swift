import Foundation

import SharedUtils

import ReSwift

public func appReducer(action: Action, state: AppState?) -> AppState {
    var newState = state ?? AppState.default

    newState.location = locationReducer(action: action, state: newState.location)

    // If permissions are granted, start updating user location
    if let locationAction = action as? LocationAction {
        switch locationAction {
        case .permissionsGrantedAlways, .permissionsGrantedInUse:
            newState.location.status = .running
        default:
            break
        }
    }

    return newState
}
