import UIKit

public extension UICollectionView {
    public func registerHeader(_ nibName: String, bundle: Bundle? = nil) {
        self.register(UINib(nibName: nibName, bundle: bundle), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: nibName)
    }

    public func registerFooter(_ nibName: String, bundle: Bundle? = nil) {
        self.register(UINib(nibName: nibName, bundle: bundle), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: nibName)
    }

    public func registerCell(_ nibName: String, bundle: Bundle? = nil) {
        self.register(UINib(nibName: nibName, bundle: bundle), forCellWithReuseIdentifier: nibName)
    }
}

