import UIKit

public struct LayoutUtils {
    public static func fill(_ container: UIView, view: UIView) {
        let constraints: [NSLayoutConstraint] = [
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        container.addConstraints(constraints)
    }

    public static func fill(_ parent: UIView, views: [UIView], axis: UILayoutConstraintAxis) -> [NSLayoutConstraint] {
        let constraints: [NSLayoutConstraint] = views.flatMap { (view) -> [NSLayoutConstraint] in
            switch axis {
            case .vertical:
                return [
                    NSLayoutConstraint(item: parent, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: parent, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
                ]
            case .horizontal:
                return [
                    NSLayoutConstraint(item: parent, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: parent, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
                ]
            }
        }

        parent.addConstraints(constraints)

        return constraints
    }

    public static func distribute(_ views: [UIView], parent: UIView, axis: UILayoutConstraintAxis) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        let finalView: UIView? = views.reduce(nil) { (previous, view) in
            switch axis {
            case .vertical:
                if let previous = previous {
                    constraints.append(NSLayoutConstraint(item: previous, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
                }
                else {
                    constraints.append(NSLayoutConstraint(item: parent, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
                }

            case .horizontal:
                if let previous = previous {
                    constraints.append(NSLayoutConstraint(item: previous, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
                }
                else {
                    constraints.append(NSLayoutConstraint(item: parent, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
                }
            }

            return view
        }

        switch axis {
        case .vertical:
            if let finalView = finalView {
                constraints.append(NSLayoutConstraint(item: parent, attribute: .bottom, relatedBy: .equal, toItem: finalView, attribute: .bottom, multiplier: 1, constant: 0))
            }
        case .horizontal:
            if let finalView = finalView {
                constraints.append(NSLayoutConstraint(item: parent, attribute: .trailing, relatedBy: .equal, toItem: finalView, attribute: .trailing, multiplier: 1, constant: 0))
            }
        }

        parent.addConstraints(constraints)

        return constraints
    }

    public static func keepAspectRatio(view: UIView, width: CGFloat, height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false

        let finalHeight: CGFloat = height == 0 ? 1 : height
        let ratio = width/finalHeight

        let constraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: ratio, constant: 0)
        constraint.priority = priority

        view.addConstraint(constraint)
        return constraint
    }

    public static func keepAspectRatio(imageView: UIImageView, currentConstraint: NSLayoutConstraint?, priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint? {
        guard let image = imageView.image else { return nil }

        imageView.translatesAutoresizingMaskIntoConstraints = false

        let height: CGFloat = image.size.height == 0 ? 1 : image.size.height
        let ratio = image.size.width/height

        let constraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: ratio, constant: 0)
        constraint.priority = priority

        currentConstraint.map(imageView.removeConstraint)
        imageView.addConstraint(constraint)
        return constraint
    }
}

