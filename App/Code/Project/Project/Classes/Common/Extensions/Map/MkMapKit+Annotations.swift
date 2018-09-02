import Foundation
import MapKit

public extension MKMapView {

    func bringUserAnnotationToFront() {

        self.annotations.forEach { annotation in
            if annotation as? MKUserLocation != nil {
                guard let viewUser = self.view(for: annotation) else {
                    return
                }
                DispatchQueue.main.async {
                    viewUser.superview?.bringSubview(toFront: viewUser)
                }
            }
        }

    }

    func deselectSelectedAnnotations(animated: Bool = true) {
        self.selectedAnnotations.forEach { annotation in
            DispatchQueue.main.async {
                self.deselectAnnotation(annotation, animated: animated)
            }
        }
    }

}
