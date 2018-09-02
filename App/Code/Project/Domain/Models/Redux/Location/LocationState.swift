import Foundation
import CoreLocation

import ReSwift

public enum LocationStateStatus {
    case running
    case stopped
}

public struct LocationState: StateType {

    // MARK: Properties

    /**
     Last known location
     */
    public var lastLocation: CLLocation?

    /**
     Retains error if something happened
     */
    // sourcery: skipDescription
    public var locationError: Error?

    /**
     Desired accuracy for GPS
     */
    public var accuracy: CLLocationAccuracy = kCLLocationAccuracyHundredMeters

    /**
     Minimum distance to trigger GPS changes
     */
    public var distanceFilter: CLLocationDistance = 100.0

    /**
     Status of the manager
     */
    public var status: LocationStateStatus = .stopped

    /**
     permissionStatus: User permission's status
     - NotDetermined: User has not yet made a choice with regards to this application
     - Restricted: The app is not authorized to use location services. Due
     to active restrictions on location services, the user cannot change
     this status, and may not have personally denied authorization
     - Denied: User has explicitly denied authorization for this application,
     or location services are disabled in Settings.
     - AuthorizedAlways: User has granted authorization to use their location at any time,
     including monitoring for regions, visits, or significant location changes.
     - AuthorizedWhenInUse: User has granted authorization to use their location only when your app
     is visible to them (it will be made visible to them if you continue to
     receive location updates while in the background).  Authorization to use
     launch APIs has not been granted.
     */
    public var permissionStatus: CLAuthorizationStatus = .notDetermined

    static var `default`: LocationState {
        return LocationState()
    }

}

extension LocationState: AutoCases, AutoEquatableTRN, AutoHashableTRN { }

public extension LocationState {

    var isAuthorized: Bool? {
        switch self.permissionStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied, .restricted:
            return false
        case .notDetermined:
            return nil
        }
    }

}
