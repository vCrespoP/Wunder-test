import Foundation

public enum FontUtils {

    static let isSystemFontErrorCode = 105

    public static func registerFont(at url: URL) -> Bool {
        let cUrl = url as CFURL

        CTFontManagerUnregisterFontsForURL(cUrl, .none, nil)

        //		let fonts = CTFontManagerCreateFontDescriptorsFromURL(cUrl) as? [CTFontDescriptor]
        //
        //		let name = fonts?.first.flatMap { CTFontDescriptorCopyAttribute($0, kCTFontNameAttribute) as? String }
        //
        //		dump(name)

        var errorRef: Unmanaged<CFError>?
        let result = CTFontManagerRegisterFontsForURL(cUrl, .none, &errorRef)

        let error = errorRef.flatMap { $0.takeRetainedValue() as Error as NSError }

        return error?.code == isSystemFontErrorCode ? true : result
    }
}
