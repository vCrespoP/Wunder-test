import UIKit

public extension UINib {
    public static func loadNib(_ owner: AnyObject, nibName: String, bundle: Bundle? = nil) -> UIView? {
        guard nibName.count > 0 else { return nil }

        return UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: owner, options: nil).first as? UIView
    }
}

