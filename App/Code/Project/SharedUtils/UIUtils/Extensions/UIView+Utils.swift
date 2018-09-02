import UIKit

public extension UIView {
    public static func removeAllSubviews(view: UIView) {
        view.removeSubviews(views: view.subviews)
    }

    public func removeAllSubviews() {
        UIView.removeAllSubviews(view: self)
    }

    public func removeSubviews(views: [UIView]) {
        for subview in views {
            subview.removeFromSuperview()
        }
    }

    public static func addSubviews(view: UIView, subviews: [UIView]) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }

    public func addSubviews(subviews: [UIView]) {
        UIView.addSubviews(view: self, subviews: subviews)
    }
}

