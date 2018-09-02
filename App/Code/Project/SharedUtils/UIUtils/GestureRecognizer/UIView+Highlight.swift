import Foundation
import UIKit

extension UIView {

    public func recognizeHighlight() {
        let touchDownGesture = PressDownGestureRecognizer(target: self, action: #selector(touchDown(_:)))
        touchDownGesture.cancelsTouchesInView = false // Important or else, cells won't be able to be selected
        self.addGestureRecognizer(touchDownGesture)
    }

    @objc fileprivate func touchDown(_ gestureRecognizer: UIGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            self.alpha = 0.5
        case .changed:
            break
        case .ended:
            self.alpha = 1.0
        default:
            break
        }
    }

}
