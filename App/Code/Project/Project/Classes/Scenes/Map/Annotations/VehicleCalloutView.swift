import Foundation
import UIKit

import Domain

//import ReSwift

class VehicleCalloutView: UIView {

    // MARK: Properties
    typealias LeftActionHandler = () -> ()
    typealias RightActionHandler = () -> ()
    var vehicle: Vehicle!
    var actionLeft: LeftActionHandler?
    var actionRight: RightActionHandler?

    // MARK: Outlets
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var btBg: UIButton!

    @IBOutlet weak var lbDescription: UILabel!

    @IBOutlet weak var btExterior: UIButton!
    @IBOutlet weak var btInterior: UIButton!

    @IBOutlet weak var imgBattery: UIImageView!
    @IBOutlet weak var lbBattery: UILabel!
    @IBOutlet weak var imgAddress: UIImageView!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbAddress2: UILabel!
    @IBOutlet weak var imgDistance: UIImageView!
    @IBOutlet weak var lbDistance: UILabel!

    @IBOutlet weak var btGoToVehicle: UIButton!
    @IBOutlet weak var btBookVehicle: UIButton!

    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        self.btGoToVehicle.backgroundColor = ThemeColor.bgPrimaryLight

        self.btBookVehicle.backgroundColor = ThemeColor.bgPrimaryDark

        self.viewBg.applyArrowDialogAppearanceWithOrientation(arrowOrientation: .down)

        self.btGoToVehicle.setTitle("Go to vehicle", for: .normal)
        self.btBookVehicle.setTitle("+ Info", for: .normal)

        self.btExterior.isUserInteractionEnabled = false
        self.btInterior.isUserInteractionEnabled = false

        // Images
        self.imgBattery.image = self.imgBattery.image?
            .withRenderingMode(.alwaysTemplate)
            .tinted(with: ThemeColor.bgPrimaryDark)
        self.imgAddress.image = self.imgAddress.image?
            .withRenderingMode(.alwaysTemplate)
            .tinted(with: ThemeColor.bgPrimaryDark)
        self.imgDistance.image = self.imgDistance.image?
            .withRenderingMode(.alwaysTemplate)
            .tinted(with: ThemeColor.bgPrimaryDark)
        
        // Labels
        self.lbDescription.text = nil
        self.lbBattery.text = nil
        self.lbAddress.text = nil
        self.lbAddress2.text = nil
        self.lbDistance.text = nil
    }

    // MARK: - Hit test. We need to override this to detect hits in our custom callout.
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Check if it hit our annotation detail view components.

        // UI Elements to Hit Test
        if let result = self.btGoToVehicle.hitTest(convert(point, to: self.btGoToVehicle), with: event) {
            return result
        }

        if let result = self.btBookVehicle.hitTest(convert(point, to: self.btBookVehicle), with: event) {
            return result
        }

        // Fallback
        return self.btBg.hitTest(convert(point, to: self.btBg), with: event)
    }

    // MARK: IBActions
    @IBAction func btGoToVehicleTap(_ sender: UIButton) {
        Log.debug("Go tapped")
        self.actionLeft?()
    }

    @IBAction func btBookVehicleTap(_ sender: UIButton) {
        Log.debug("Book tapped")
        self.actionRight?()
    }

    // MARK: Public methods
    func fill(vehicle: Vehicle, actionLeft: LeftActionHandler? = nil, actionRight: RightActionHandler? = nil) {
        self.vehicle = vehicle
        self.actionLeft = actionLeft
        self.actionRight = actionRight

        self.lbDescription.text = vehicle.nameFormatted

        self.btExterior.tintColor = vehicle.exteriorColor
        self.btInterior.tintColor = vehicle.interiorColor

        self.lbBattery.text = "\(vehicle.fuelFormatted)"
        self.lbAddress.text = vehicle.address1Formatted
        self.lbAddress2.text = vehicle.address2Formatted

        if let currentLocation = Application.shared.context.currentLocation {
            self.lbDistance.text = vehicle.distanceFormatted(from: currentLocation)
        } else {
            self.lbDistance.text = ""
        }
    }

    // MARK: Private Methods

}

//extension VehicleCalloutView: StoreSubscriber {
//
//
//
//}
