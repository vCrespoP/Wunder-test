import Foundation

extension UIActivityIndicatorView {
    public func update(isLoading: Bool) {
        if isLoading {
            startAnimating()
        }
        else {
            stopAnimating()
        }
    }
}
