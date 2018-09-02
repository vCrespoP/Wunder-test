import Foundation
import CoreLocation

import ReSwift
import SharedUtils

public func locationReducer(action: Action, state: LocationState) -> LocationState {

    guard let action = action as? LocationAction else {
        return state
    }

    var newState = state

    // Reset error so it doesn't get stuck with this state
    newState.locationError = nil

    switch action {

    case .stopUpdates:
        newState.status = .stopped

    case .resumeUpdates:
        newState.status = .running

    case .newLocation(let location):
        newState.lastLocation = location

    case .newLocationError(let error):
        newState.locationError = error

    case .permissionsNotDetermined:
        newState.permissionStatus = .notDetermined

    case .permissionsRestricted:
        newState.permissionStatus = .restricted

    case .permissionsDenied:
        newState.permissionStatus = .denied

    case .permissionsGrantedInUse:
        newState.permissionStatus = .authorizedWhenInUse

    case .permissionsGrantedAlways:
        newState.permissionStatus = .authorizedAlways

    case .changeAccuracy(let accuracy):
        newState.accuracy = accuracy

    case .changeDistanceFilter(let distance):
        newState.distanceFilter = distance

    }

    return newState
}
