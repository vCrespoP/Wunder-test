import Foundation
import MapKit

protocol Reusable {

    static var reuseId: String { get }

}

extension Reusable {

    static var reuseId: String {
        return String(describing: self)
    }

}

// Map
extension MKAnnotationView: Reusable {}

// View Controller
extension UIViewController: Reusable {}

// Table
extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}

extension UITableView {

    func registerCellNib<T: Reusable>(ofType cellType: T.Type = T.self) {
        let nib = UINib(nibName: cellType.reuseId, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellType.reuseId)
    }

    func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }

    func registerHeaderFooterNib<T: Reusable>(ofType cellType: T.Type = T.self) {
        let nib = UINib(nibName: cellType.reuseId, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: cellType.reuseId)
    }

    func dequeueReusableHeaderFooter<T>(ofType cellType: T.Type = T.self) -> T where T: UITableViewHeaderFooterView {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: cellType.reuseId) as? T else {
            fatalError()
        }
        return headerFooter
    }

}

// Collection
extension UICollectionViewCell: Reusable {}

extension UICollectionView {

    func registerCellNib<T: Reusable>(ofType cellType: T.Type = T.self) {
        let nib = UINib(nibName: cellType.reuseId, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: cellType.reuseId)
    }

    func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }

    func registerHeaderNib<T: Reusable>(ofType cellType: T.Type = T.self) {
        let nib = UINib(nibName: cellType.reuseId, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellType.reuseId)
    }

    func registerFooterNib<T: Reusable>(ofType cellType: T.Type = T.self) {
        let nib = UINib(nibName: cellType.reuseId, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: cellType.reuseId)
    }

    func dequeueReusableHeader<T: Reusable>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UICollectionReusableView {
        guard let headerFooter = dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError()
        }
        return headerFooter
    }

    func dequeueReusableFooter<T: Reusable>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UICollectionReusableView {
        guard let headerFooter = dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError()
        }
        return headerFooter
    }

}

// Storyboard
extension UIStoryboard {

    func instantiateInitialViewController<T>() -> T where T: UIViewController {
        guard let viewController = instantiateInitialViewController() as? T else {
            fatalError()
        }
        return viewController
    }

    func instantiateViewController<T>(ofType type: T.Type = T.self) -> T where T: UIViewController {
        guard let viewController = instantiateViewController(withIdentifier: type.reuseId) as? T else {
            fatalError()
        }
        return viewController
    }

}

// UIView
extension UIView {

    static func instantiateView<T: Reusable>(ofType type: T.Type = T.self) -> T where T: UIView {
        guard let view = UINib(nibName: type.reuseId, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError()
        }
        return view
    }

}
