import Foundation
import MapKit

extension MapViewController {

    func configureMap(_ map: MKMapView) {

        map.delegate = self

        map.mapType = .standard
        map.showsUserLocation = true
        map.showsScale = true
        map.showsCompass = true

        map.mapType = .standard // .satellite | .hybrid
        map.showsUserLocation = true
        map.showsScale = true
        map.showsCompass = true

        if #available(iOS 11.0, *) {
            map.register(MKAnnotationViewVehicle.self,
                         forAnnotationViewWithReuseIdentifier: MKAnnotationViewVehicle.reuseId)
            map.register(MKAnnotationClusterViewVehicle.self,
                         forAnnotationViewWithReuseIdentifier: MKAnnotationClusterViewVehicle.reuseId)
        }

    }

}

// MARK: - MKMapView Delegate
extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //        mapView.setCenter(userLocation.coordinate, animated: true)
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        Log.debug("\nCoordinate NE: \(mapView.coordinateNE) \nCoordinate SW: \(mapView.coordinateSW)")
        DispatchQueue.main.async {
            mapView.bringUserAnnotationToFront()
        }
    }

    @available(iOS 11.0, *)
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {

        let vehicles = MKClusterAnnotation(memberAnnotations: memberAnnotations)
        vehicles.title = vehicles.memberAnnotations.first?.title!
        vehicles.subtitle = "+ \(vehicles.memberAnnotations.count - 1)"
        return vehicles
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        // Do not treat user annotation
        guard annotation as? MKUserLocation == nil else {
            return nil
        }

        // Vehicle
        if annotation as? MKAnnotationVehicle != nil {
            let identifier = MKAnnotationVehicle.reuseId
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if let annotationView = annotationView {
                annotationView.annotation = annotation
            } else {
                let annotationVehicleView = MKAnnotationViewVehicle(annotation: annotation, reuseIdentifier: identifier)
                annotationVehicleView.handleActions(left: {
                    self.showDemoLimitation()
                }, right: {
                    self.showDemoLimitation()
                })
                annotationView = annotationVehicleView
            }
            return annotationView
        }

        // Cluster
        if #available(iOS 11.0, *) {
            if annotation as? MKClusterAnnotation != nil {
                let identifier = MKAnnotationClusterViewVehicle.reuseId
                var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                if let annotationView = annotationView {
                    annotationView.annotation = annotation
                } else {
                    let annotationClusterVehicleView = MKAnnotationClusterViewVehicle(annotation: annotation, reuseIdentifier: identifier)
                    annotationView = annotationClusterVehicleView
                }
                return annotationView
            }
        }

        // Do no treat anything else
        return nil

    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        // User location ~> Do nothing
        if view.annotation as? MKUserLocation != nil {
            return
        }

        // If callout is being shown, deselect everything
        if self.isCalloutShown == true {
            mapView.deselectSelectedAnnotations(animated: false)
            self.isCalloutShown = false
            return
        }

        // Vehicle annotation ~> Bring to front and hide the rest
        if let annotation = view.annotation as? MKAnnotationVehicle {

            Log.debug("Selected vehicle: \(annotation.item.name ?? "?")")

            // Handle selection action
            let coordinate = annotation.coordinate
            self.centerOn(latitude: coordinate.latitude, longitude: coordinate.longitude)

            // Handle manual deselection
            let deselectTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
            view.addGestureRecognizer(deselectTap)

            // Calculate all annotations except user location and this one
            let annotationsTohide = mapView.annotations.filter {
                if $0 as? MKUserLocation != nil {
                    return false
                }
                if let annotationVehicle = $0 as? MKAnnotationVehicle {
                    if annotationVehicle == annotation {
                        return false
                    }
                }
                return true
            }

            // Hide everything except user location and this one
            DispatchQueue.main.async {
                mapView.removeAnnotations(annotationsTohide)
            }

        }

        // Cluster annotation ~> Do nothing
        if view.annotation as? MKAnnotationClusterViewVehicle != nil {
            return
        }

    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {

        // User location ~> Do nothing
        if view.annotation as? MKUserLocation != nil {
            return
        }

        // Vehicle annotation ~> Send to back again
        if let annotation = view.annotation as? MKAnnotationVehicle {

            Log.debug("Deselected vehicle: \(annotation.item.name ?? "?")")

            // Handle selection action

            // Restore all annotations
            self.fillWith(vehicles: self.presenter?.items ?? [])

            return
        }

        // Cluster annotation ~> Do nothing
        if view.annotation as? MKAnnotationClusterViewVehicle != nil {
            return
        }

    }

}

fileprivate extension MapViewController {

    @objc func handleTap(sender: UIGestureRecognizer? = nil) {
        self.mapVehicles.deselectSelectedAnnotations()
        self.isCalloutShown = true
    }

}

