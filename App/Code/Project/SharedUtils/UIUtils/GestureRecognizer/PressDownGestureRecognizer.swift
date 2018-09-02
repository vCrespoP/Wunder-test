import Foundation
import UIKit.UIGestureRecognizerSubclass

class PressDownGestureRecognizer: UIGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .possible {
            self.state = .began
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        // self.state = .failed
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .recognized
    }

}
