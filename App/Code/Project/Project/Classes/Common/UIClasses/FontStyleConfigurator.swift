import Foundation

enum Fonts: String {
    case GothamLight = "Gotham-Light"
    case Gotham = "Gotham-Medium"
    case GothamBold = "Gotham-Bold"

    case System = "HelveticaNeue"
    case SystemLight = "HelveticaNeue-Light"
    case SystemBold = "HelveticaNeue-Bold"

    func of(size: CGFloat) -> UIFont {
        let calculatedSize = UIScreen.main.scale > 2 ? size : size - 1
        return UIFont(name: self.rawValue, size: calculatedSize)!
    }

    func forStyle(_ style: UIFontTextStyle) -> UIFont {
        let calculatedSize = UIFont.preferredFont(forTextStyle: style).pointSize
        return UIFont(name: self.rawValue, size: calculatedSize)!
    }
}

extension UIFont {

    static var title: UIFont {
        return Fonts.System.of(size: 19.0)
    }

    static var smallTitle: UIFont {
        return Fonts.System.of(size: 14.0)
    }

    static var subtitle: UIFont {
        return Fonts.System.of(size: 14.0)
    }

    static var cardSubtitle: UIFont {
        return Fonts.System.of(size: 14.0)
    }

    static var button: UIFont {
        return Fonts.System.of(size: 14.0)
    }

    static var body: UIFont {
        return Fonts.System.of(size: 14.0)
    }

    static var version: UIFont {
        return Fonts.System.of(size: 12.0)
    }

}

