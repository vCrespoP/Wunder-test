import UIKit
import DeviceKit

extension UIViewController {

    func placeLogoInNavigationBar() {
        guard let logo = UIImage(named: "app") else {
            return
        }

//        let logoResized = logo.resize(targetSize: CGSize(
//            width: 110, // logo.size.width * 0.05,
//            height: 19)) //logo.size.height * 0.05))

        let device = Device()
        switch device {
        case .iPhoneX, .simulator(.iPhoneX):
            self.navigationItem.titleView = UIImageView(image: logo)
        default:
            self.navigationItem.titleView = UIImageView(image: logo)
        }

    }

}
