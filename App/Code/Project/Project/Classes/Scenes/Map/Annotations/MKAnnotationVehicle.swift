import Foundation
import MapKit

import Domain

class MKAnnotationVehicle: NSObject, PRMKAnnotation {
    typealias MapItem = Vehicle

    // MARK: properties
    var item: Vehicle
    var coordinate: CLLocationCoordinate2D {
        return self.item.coreLocationCoordinate! // Make sure this exists when creating
    }

    // MARK: Life Cycle
    required init(_ item: Vehicle) {
        self.item = item

        super.init()
    }

    var title: String? {
        return self.item.name
    }

    var subtitle: String? {
        return self.item.address
    }

}

