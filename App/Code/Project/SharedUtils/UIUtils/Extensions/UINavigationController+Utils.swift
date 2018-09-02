import UIKit

public extension UINavigationController {

    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> ()) {
        pushViewController(viewController, animated: animated)

        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }

    public func popViewController(_ animated: Bool, completion: @escaping () -> ()) {
        self.popViewController(animated: animated)

        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }

    // Returns true if found, false if not found
    func backToViewController(_ vc: AnyClass) -> Bool {
        var found = false
        for controller in self.viewControllers {
            if controller.isKind(of: vc) {
                self.popToViewController(controller, animated: true)
                found = true
                break
            }
        }
        return found
    }

    func containsController(_ vc: AnyClass) -> Bool {
        for controller in self.viewControllers {
            if controller.isKind(of: vc) {
                return true
            }
        }
        return false
    }

    func replaceTopViewController(with viewController: UIViewController, animated: Bool) {
        var vcs = viewControllers
        vcs[vcs.count - 1] = viewController
        setViewControllers(vcs, animated: animated)
    }

    func removePreviousControllers(exceptFirsts: Int, includingCurrent: Bool = false) {
        let controllersCount = self.viewControllers.count
        let finalIndex = includingCurrent == true ? controllersCount : controllersCount - 1
        self.viewControllers.removeSubrange(exceptFirsts ..< finalIndex)
    }

}
