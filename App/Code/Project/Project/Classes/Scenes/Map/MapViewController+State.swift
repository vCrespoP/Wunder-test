import Foundation

import Domain

import ReSwift

extension MapViewController: StoreSubscriber {

    func newState(state: AppState) {

        defer {
            self.previousState = state
        }

        guard self.previousState != state else {
            return
        }

    }

}
