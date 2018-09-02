import UIKit

public extension UIFont {

    var monospacedDigitFont: UIFont {
        let oldFontDescriptor = fontDescriptor
        let newFontDescriptor = oldFontDescriptor.monospacedDigitFontDescriptor
        return UIFont(descriptor: newFontDescriptor, size: self.pointSize)
    }

    private static let isSystemFontErrorCode = 105

    static func registerFont(at url: URL) -> Bool {

        let cUrl = url as CFURL

        CTFontManagerUnregisterFontsForURL(cUrl, .none, nil)

        var errorRef: Unmanaged<CFError>?
        let result = CTFontManagerRegisterFontsForURL(cUrl, .none, &errorRef)

        let error = errorRef.flatMap { $0.takeRetainedValue() as Error as NSError }

        return error?.code == isSystemFontErrorCode ? true : result
    }

    static func fonts(at url: URL) -> [String] {

        let cUrl = url as CFURL

        CTFontManagerUnregisterFontsForURL(cUrl, .none, nil)

        let fonts = CTFontManagerCreateFontDescriptorsFromURL(cUrl) as? [CTFontDescriptor]
        let names = fonts?.compactMap { CTFontDescriptorCopyAttribute($0, kCTFontNameAttribute) as? String }

        return names ?? []
    }

}

private extension UIFontDescriptor {
    var monospacedDigitFontDescriptor: UIFontDescriptor {
        let fontDescriptorFeatureSettings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType, UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]
        let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings]
        let fontDescriptor = self.addingAttributes(fontDescriptorAttributes)
        return fontDescriptor
    }
}

