import Foundation

import ReSwift

extension Store {

    open func dispatchMain(_ action: Action) {
        DispatchQueue.main.async {
            self.dispatch(action)
        }
    }

}
