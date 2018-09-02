import Foundation
import UIKit

extension String {

    public func attributedWith(color: UIColor) -> NSMutableAttributedString {
        let result = NSMutableAttributedString(
            string: self,
            attributes: [
                NSAttributedStringKey.foregroundColor: color
            ]
        )
        return result
    }

}
