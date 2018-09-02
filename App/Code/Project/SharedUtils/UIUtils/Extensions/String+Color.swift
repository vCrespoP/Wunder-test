import Foundation
import UIKit

extension String {

    public func attributedWith(foregroundColor: UIColor) -> NSMutableAttributedString {
        let result = NSMutableAttributedString(
            string: self,
            attributes: [
                NSAttributedStringKey.foregroundColor: foregroundColor
            ]
        )
        return result
    }

}
