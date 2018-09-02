import Foundation
import MapKit

class MKAnnotationViewVehicle: MKAnnotationView {

    // MARK: Properties
    weak var customCalloutView: VehicleCalloutView?
    let kAnimationTime: TimeInterval = 0.5
    typealias LeftActionHandler = () -> ()
    var leftActionHandler: LeftActionHandler?
    typealias RightActionHandler = () -> ()
    var rightActionHandler: RightActionHandler?

    override var annotation: MKAnnotation? {
        willSet {
            self.update(annotation: newValue) // Completely needed so clustering works in all cases
            self.customCalloutView?.removeFromSuperview()
        }
    }

    // MARK: - Life Cycle
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        guard let annotation = self.annotation as? MKAnnotationVehicle else {
            return
        }

        self.update(annotation: annotation)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false // Show or not system callout
        if let annotation = self.annotation as? MKAnnotationVehicle {
            
            let imageProcessed = self.itemImage(annotation: annotation)
            self.image = imageProcessed
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.customCalloutView?.removeFromSuperview()
    }

    // MARK: - Hit Test
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // If super passed hit test, return the result
        if let parentHitView = super.hitTest(point, with: event) {
            return parentHitView
        }
        guard let customCalloutView = self.customCalloutView else {
            return nil
        }
        return customCalloutView.hitTest(convert(point, to: customCalloutView), with: event)
    }

    // MARK: - Callout showing and hiding
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        switch selected {

        case true:
            DispatchQueue.main.async {
                self.showCallout(animated: animated)
            }

        case false:
            DispatchQueue.main.async {
                self.hideCallout(animated: animated)
            }
        }

    }

    func handleActions(left: LeftActionHandler? = nil, right: RightActionHandler? = nil) {
        self.leftActionHandler = left
        self.rightActionHandler = right
    }

}

// MARK: Private methods
fileprivate extension MKAnnotationViewVehicle {

    func showCallout(animated: Bool) {
        self.customCalloutView?.removeFromSuperview() // Remove old custom callout (if any)

        guard let newCustomCalloutView = self.loadDetailMapView() else {
            return
        }

        // Fix location from top-left to its right place.
        newCustomCalloutView.frame.origin.x -= newCustomCalloutView.frame.width / 2.0 - (self.frame.width / 2.0)
        newCustomCalloutView.frame.origin.y -= newCustomCalloutView.frame.height

        // Set custom callout view
        self.addSubview(newCustomCalloutView)
        self.customCalloutView = newCustomCalloutView

        // animate presentation
        if animated {
            self.customCalloutView!.alpha = 0.0
            UIView.animate(withDuration: kAnimationTime, animations: {
                self.customCalloutView!.alpha = 1.0
            })
        }

    }

    func hideCallout(animated: Bool) {
        guard let customCalloutView = self.customCalloutView else {
            return
        }

        if animated {
            // Fade out animation, then remove it.
            UIView.animate(withDuration: kAnimationTime, animations: {
                customCalloutView.alpha = 0.0
            }, completion: { (success) in
                customCalloutView.removeFromSuperview()
            })
        } else {
            // Just remove it.
            customCalloutView.removeFromSuperview()
        }

    }

    func loadDetailMapView() -> VehicleCalloutView? {

        guard let view = Bundle(for: VehicleCalloutView.self)
            .loadNibNamed("VehicleCalloutView", owner: self, options: nil)?
            .first as? VehicleCalloutView else {
                return nil
        }

        guard let annotationVehicle = self.annotation as? MKAnnotationVehicle else {
            return nil
        }
        let vehicle = annotationVehicle.item
        DispatchQueue.main.async {
            view.fill(vehicle: vehicle,
                      actionLeft: { [weak self] in
                        self?.leftActionHandler?()
                },
                      actionRight: { [weak self] in
                        self?.rightActionHandler?()
            })
        }

        return view
    }

    func itemImage(annotation: MKAnnotationVehicle) -> UIImage? {
        let imageProcessed = annotation.item.annotationImage
//            .withRenderingMode(.alwaysTemplate)
//            .tinted(with: ThemeColor.bgSecondaryDark.withAlphaComponent(0.7))
        return imageProcessed
    }
    
    func update(annotation: MKAnnotation?) {
        guard let annotation = annotation as? MKAnnotationVehicle else {
            return
        }
        self.canShowCallout = false // Show or not system callout
        let imageProcessed = self.itemImage(annotation: annotation)
        self.image = imageProcessed
        let verticalOffset = (self.image?.size.height ?? 0) / 2
        self.centerOffset = CGPoint(x: 0.0, y: -verticalOffset)

        // Cluster configuration
        if #available(iOS 11.0, *) {
            self.clusteringIdentifier = MKAnnotationClusterViewVehicle.reuseId
            self.displayPriority = .defaultHigh
        }
    }

}
