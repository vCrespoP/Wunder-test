import UIKit

import SharedUtils

extension UIViewController {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: TypeUtils.name(self), bundle: nil)
    }
}
