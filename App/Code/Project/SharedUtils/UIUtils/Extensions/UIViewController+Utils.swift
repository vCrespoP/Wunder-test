import UIKit

// MARK: Storyboard
public extension UIViewController {
    static var storyboard: UIStoryboard {
        let name = String(describing: self)
        return UIStoryboard(name: name, bundle: nil)

    }
}

// MARK: Embed
public extension UIViewController {
    func embed(_ child: UIViewController, inView: UIView) -> UIViewController {
        _ = self.embed(child) {
            child.view.translatesAutoresizingMaskIntoConstraints = false
            inView.addSubview(child.view)

            let constraints = [
                NSLayoutConstraint(item: inView, attribute: .top, relatedBy: .equal, toItem: child.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: inView, attribute: .bottom, relatedBy: .equal, toItem: child.view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: inView, attribute: .leading, relatedBy: .equal, toItem: child.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: inView, attribute: .trailing, relatedBy: .equal, toItem: child.view, attribute: .trailing, multiplier: 1, constant: 0)
            ]

            inView.addConstraints(constraints)
        }
        return child
    }

    func embed(_ child: UIViewController, addSubview: ()->()) -> UIViewController {
        self.addChildViewController(child)
        addSubview()
        child.didMove(toParentViewController: self)
        return child
    }

    func unembed(_ child: UIViewController) {
        child.willMove(toParentViewController: self)
        child.view.removeFromSuperview()
        child.removeFromParentViewController()
    }
}

