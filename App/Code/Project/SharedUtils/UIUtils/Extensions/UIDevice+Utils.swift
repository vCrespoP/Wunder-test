import UIKit

public extension UIDevice {

    // MARK: Language

    public static var languageCode: String {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode) as! String
    }

    public static var locale: Locale {
        return Locale.current
    }

    // MARK: Device Type

    public static var isIPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    public static var isIPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    public static var isSimulator: Bool {
        #if arch(i386) || arch(x86_64)
        return true
        #else
        return false
        #endif
    }

    public static var screenScale: CGFloat {
        return UIScreen.main.scale
    }
}

