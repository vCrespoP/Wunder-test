import Foundation
import UIKit

import Kingfisher

extension UIImageView {

    typealias ImageHandler = (_ image: UIImage?) -> Void
    func setImage(with urlString: String?, completion: ImageHandler? = nil) {
        self.kf.indicatorType = .activity
        guard let url = urlString else {
            self.kf.setImage(with: nil)
            completion?(nil)
            return
        }
        self.kf.setImage(with: URL(string: url), completionHandler: { image, _, _, _ in
            completion?(image)
        })
    }

}

