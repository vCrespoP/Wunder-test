import Foundation

import Domain

class CellVehicle: UITableViewCell {

    // MARK: Properties
    static var reuseId: String = "CellVehicle"

    // MARK: Outlets
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbAddress2: UILabel!

    @IBOutlet weak var lbDistance: UILabel!
    @IBOutlet weak var lbBattery: UILabel!
    @IBOutlet weak var btExterior: UIButton!
    @IBOutlet weak var btInterior: UIButton!

    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        self.btExterior.isUserInteractionEnabled = false
        self.btInterior.isUserInteractionEnabled = false
    }

    // MARK: Public methods
    func fill(with item: Vehicle) {
        self.lbDescription.text = item.nameFormatted
        self.lbAddress.text = item.address1Formatted
        self.lbAddress2.text = item.address2Formatted

        if let location = Application.shared.context.currentLocation {
            self.lbDistance.text = item.distanceFormatted(from: location)
        } else {
            self.lbDistance.text = ""
        }

        self.lbBattery.text = "\(item.fuelFormatted)"

        self.btExterior.tintColor = item.exteriorColor
        self.btInterior.tintColor = item.interiorColor

    }

}

fileprivate extension CellVehicle {

}
