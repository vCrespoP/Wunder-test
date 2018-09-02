import Foundation
import CoreLocation

import ReSwift

public enum LocationAction: Action {

    case stopUpdates
    case resumeUpdates

    case newLocation(CLLocation)
    case newLocationError(Error)

    case permissionsNotDetermined
    case permissionsRestricted
    case permissionsDenied
    case permissionsGrantedInUse
    case permissionsGrantedAlways

    case changeAccuracy(CLLocationAccuracy)
    case changeDistanceFilter(CLLocationDistance)
}
