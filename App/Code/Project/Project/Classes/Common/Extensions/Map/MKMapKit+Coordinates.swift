import Foundation
import MapKit

extension MKMapView {

    var coordinateNE: CLLocationCoordinate2D {
        let mRect = self.visibleMapRect
        return self.coordinateFrom(x: MKMapRectGetMaxX(mRect), y: mRect.origin.y)
    }

    var coordinateNW: CLLocationCoordinate2D {
        let mRect = self.visibleMapRect
        return self.coordinateFrom(x: MKMapRectGetMinX(mRect), y: mRect.origin.y)
    }

    var coordinateSE: CLLocationCoordinate2D {
        let mRect = self.visibleMapRect
        return self.coordinateFrom(x: MKMapRectGetMaxX(mRect), y: MKMapRectGetMaxY(mRect))
    }

    var coordinateSW: CLLocationCoordinate2D {
        let mRect = self.visibleMapRect
        return self.coordinateFrom(x: mRect.origin.x, y: MKMapRectGetMaxY(mRect))
    }

    func coordinateFrom(x: Double, y: Double) -> CLLocationCoordinate2D {
        let swMapPoint = MKMapPointMake(x, y)
        return MKCoordinateForMapPoint(swMapPoint)
    }

}
