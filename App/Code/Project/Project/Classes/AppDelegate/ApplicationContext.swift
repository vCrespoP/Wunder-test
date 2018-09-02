import Foundation
import CoreLocation

import Domain

import ReSwift

/// Context for the whole app, containing the state (Redux)
struct ApplicationContext {

    let store: Store<AppState>

    init(store: Store<AppState>) {
        self.store = store
    }
}

// MARK: Public methods
extension ApplicationContext {

    mutating func reset() {

    }

    var operationContext: OperationContext {
        return OperationContext()
    }

    var currentLocation: CLLocation? {
        let result = self.store.state.location.lastLocation
        return result
    }

}

