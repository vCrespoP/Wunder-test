import Foundation
import UIKit

class ButtonAction: UIButtonBase {

    override var defaultModel: ButtonAppearanceModel {
        return ButtonAppearanceModel(
            height: 44.0,
            cornerRadius: 22.0,
            font: UIFont.button,
            textColorNormal: ThemeColor.fontPrimaryLight,
            textColorSelected: UIColor.lightGray,
            textColorDisabled: ThemeColor.fontPrimaryLight,
            backgroundColorNormal: ThemeColor.bgSecondaryDark,
            backgroundColorDisabled: ThemeColor.bgPrimaryDisabled,
            backgroundColorHighlighted: ThemeColor.bgSecondaryDark,
            insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
            titleTransformation: { return $0?.uppercased() }
        )
    }

}
