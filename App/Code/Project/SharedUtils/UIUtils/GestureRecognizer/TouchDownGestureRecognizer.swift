import Foundation
import UIKit.UIGestureRecognizerSubclass

// https://stackoverflow.com/questions/15628133/uitapgesturerecognizer-make-it-work-on-touch-down-not-touch-up

class TouchDownGestureRecognizer: UIGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .possible {
            self.state = .recognized
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .failed
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .failed
    }

}

