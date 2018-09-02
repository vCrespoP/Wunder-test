import UIKit
import MapKit
import CoreLocation

import Log
import RxSwift
import RxCocoa
import Domain

class MapViewController: BaseViewController {

    // MARK: - Properties
    var presenter: MapPresenter?
    var previousState: AppState?

    var backupAnnotations: [MKAnnotation] = []
    var deselectTap: UITapGestureRecognizer?
    var isCalloutShown: Bool = false

    // MARK: - Outlets
    @IBOutlet weak var mapVehicles: MKMapView!
    @IBOutlet weak var btCenterMap: UIButton!
    @IBOutlet weak var btList: UIBarButtonItem!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    // MARK: - Initialization
    override func translation() {
        self.title = ""
    }

    override func initUI() {
        super.initUI()

        self.configureMap(self.mapVehicles)
        self.configureBtCenter()
        self.btList.tintColor = self.navigationController?.navigationBar.tintColor
        
    }

}

// MARK: - Public methods
extension MapViewController {

    func fillWith(vehicles: Vehicles) {
        Log.debug("Filling with (\(vehicles.count) vehicles")
        let annotations: [MKAnnotationVehicle] = vehicles.map {
            let annotation = MKAnnotationVehicle($0)
            return annotation
        }
        // Double reload safety check (User annotation + selected annotation)
        // Being greater would mean annotations are already added and shouldn't be added back again
        if self.mapVehicles.annotations.count > 2 {
            return
        }
        DispatchQueue.main.async {
            self.mapVehicles.removeAnnotations(self.mapVehicles.annotations)
            self.mapVehicles.addAnnotations(annotations)
        }
    }

    func centerOn(latitude: Double, longitude: Double, regionRadius: Double? = nil, animated: Bool = true) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        // If region radius is defined, perform zoom
        if let regionRadius = regionRadius {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 2,
                                                                      regionRadius * 2)
            DispatchQueue.main.async {
                self.mapVehicles.setRegion(coordinateRegion, animated: animated)
            }
        } else {
            // If not, just set the center
            DispatchQueue.main.async {
                self.mapVehicles.setCenter(location.coordinate, animated: animated)
            }
        }

    }

}

// MARK: - Private methods
private extension MapViewController {

    func configureBtCenter() {

        self.btCenterMap.backgroundColor = ThemeColor.bgPrimaryDark

        self.btCenterMap
            .rxTap { [weak self] in
                if let currentLocation = Application.shared.context.currentLocation {
                    let coordinate = currentLocation.coordinate
                    let regionRadius: Double = 0.5 * 1000
                    self?.centerOn(latitude: coordinate.latitude, longitude: coordinate.longitude, regionRadius: regionRadius)
                }
            }
            .disposed(by: self.disposeBag)

    }

    @IBAction func btListTap(_ sender: UIBarButtonItem) {
        self.presenter?.onList()
    }

}
