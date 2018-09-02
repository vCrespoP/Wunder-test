import Foundation
import CoreLocation

import Domain

import ReSwift

class LocationComponent: NSObject {

    // MARK: Properties
    let store: Store<AppState>
    var previousState: AppState?
    let locationManager: CLLocationManager

    // MARK: Life Cycle
    init(store: Store<AppState>) {

        self.store = store
        self.locationManager = CLLocationManager()

        super.init()
        self.locationManager.delegate = self
        store.subscribe(self)
    }

    deinit {
        store.unsubscribe(self)
    }

}

// MARK: Store Subscriber
extension LocationComponent: StoreSubscriber {

    func newState(state: AppState) {

        // Always assign new state to previous state (in the end)
        defer {
            self.previousState = state
        }

        // Check states are different
        guard state.location != previousState?.location else {
            return
        }

    }

}

// MARK: CLLocation

extension LocationComponent: CLLocationManagerDelegate {

    /**
     Manager couldn't get location
     */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.store.dispatchMain(LocationAction.newLocationError(error))
    }

    /**
     Manager got a new location
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let lastLocation = locations.last {
            store.dispatchMain(LocationAction.newLocation(lastLocation))
        }

    }

    /**
     Manager authorization status changed
     */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
        case .restricted:
            store.dispatchMain(LocationAction.permissionsRestricted)
        case .denied:
            store.dispatchMain(LocationAction.permissionsDenied)
        case .authorizedAlways:
            store.dispatch(LocationAction.permissionsGrantedAlways)
        case .authorizedWhenInUse:
            store.dispatchMain(LocationAction.permissionsGrantedInUse)
        case .notDetermined:
            store.dispatchMain(LocationAction.permissionsNotDetermined)
        }

    }

}

/**
 Public methods
 */
extension LocationComponent {

    /**
     Requests authorizaion for getting location always.
     Remember to set in .plist ~> NSLocationAlwaysUsageDescription
     */
    func requestAlwaysAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }

    /**
     Requests authorizaion for getting location when using the app.
     Remember to set in .plist ~> NSLocationWhenInUseUsageDescription
     */
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    /**
     Starts getting GPS values whenever it changes
     */
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    /**
     Stops getting GPS values whenever it changes
     */
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

}

/**
 Computed variables
 */
extension LocationComponent {

    /**
     Manages location accuracy in meters. It's possible to use these constants:
     - Best for navigation: kCLLocationAccuracyBestForNavigation
     - Best: kCLLocationAccuracyBest
     - Nearest ten meters: kCLLocationAccuracyNearestTenMeters
     - Hundred meters: kCLLocationAccuracyHundredMeters
     - Kilometer: kCLLocationAccuracyKilometer
     - 3 Kilometers: kCLLocationAccuracyThreeKilometers
     */
    var accuracy: CLLocationAccuracy? {
        get {
            return locationManager.desiredAccuracy
        }
        set {
            if let newAccuracy = newValue {
                locationManager.desiredAccuracy = newAccuracy
                store.dispatchMain(LocationAction.changeAccuracy(newAccuracy))
            }
        }
    }

    /**
     Manages location distance filter in meters.
     GPS will trigger new locations after user moves more than that distance
     */
    var distanceFilter: CLLocationDistance? {
        get {
            return locationManager.distanceFilter
        }
        set {
            if let newDistanceFilter = newValue {
                locationManager.distanceFilter = newDistanceFilter
                store.dispatchMain(LocationAction.changeDistanceFilter(newDistanceFilter))
            }
        }

    }

    /**
     Retrieves authorization status for the application
     */
    class var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

}
