import Foundation
import UIKit

extension UIWindow {

    func replaceAnimated(
        navigationController: UINavigationController,
        duration: TimeInterval = 0.3,
        options: UIViewAnimationOptions = .transitionCrossDissolve,
        completion: @escaping (Bool) -> () = { _ in }) {

        UIView.transition(with: self, duration: duration, options: options, animations: {
            self.rootViewController = navigationController
        }, completion: completion)
    }

}
