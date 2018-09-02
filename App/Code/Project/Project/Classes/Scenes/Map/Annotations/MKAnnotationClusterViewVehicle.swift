import Foundation
import MapKit

internal final class MKAnnotationClusterViewVehicle: MKAnnotationView {

    // MARK: Properties
    internal override var annotation: MKAnnotation? {
        willSet {
            if #available(iOS 11.0, *) {
                newValue.flatMap(configure(with:))
            }
        }
    }

    // MARK: Initialization
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        if #available(iOS 11.0, *) {
            self.displayPriority = .defaultHigh
            self.collisionMode = .circle
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) not implemented.")
    }

}

// MARK: Configuration
private extension MKAnnotationClusterViewVehicle {

    @available(iOS 11.0, *)
    func configure(with annotation: MKAnnotation) {

        guard let annotation = annotation as? MKClusterAnnotation else {
            return
        }

        let count = annotation.memberAnnotations.count
        self.image = UIImage.clusterIcon(color: ThemeColor.bgPrimaryDark, textColor: .white, count: count)
        self.displayPriority = .defaultLow
    }
}
