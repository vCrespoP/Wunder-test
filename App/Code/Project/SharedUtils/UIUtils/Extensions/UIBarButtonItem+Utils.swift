import UIKit

public extension UIBarButtonItem {

    public static var fixedSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    }

    public static func fixedSpace(width: CGFloat) -> UIBarButtonItem {
        let item = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        item.width = width
        return item
    }

    public static var flexibleSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }

    public static func image(name: String?) -> UIBarButtonItem {
        return image(image: name.flatMap { UIImage(named: $0) })
    }

    public static func image(image: UIImage?) -> UIBarButtonItem {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return UIBarButtonItem(customView: imageView)
    }

    public static var loadingItem: UIBarButtonItem {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.startAnimating()
        return UIBarButtonItem(customView: spinner)
    }

}

