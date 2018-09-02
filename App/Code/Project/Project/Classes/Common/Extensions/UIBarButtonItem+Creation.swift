import UIKit

extension UIBarButtonItem {
    public static func image(_ image: UIImage) -> UIBarButtonItem {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return UIBarButtonItem(customView: imageView)
    }
}
