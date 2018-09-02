import Foundation

public struct Utils {

}

public extension Utils {

    static var isSimulator: Bool {
        #if arch(i386) || arch(x86_64)
        return true
        #else
        return false
        #endif
    }

    static func formatDistance(meters: Double) -> String {
        let distance = Measurement(value: meters, unit: UnitLength.meters)

        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.unitOptions = .naturalScale
        if Utils.isSimulator {
            formatter.locale = Locale(identifier: "es-ES")
        }
        let numberFormatter = NumberFormatter()
        if meters < 1000 {
            numberFormatter.maximumFractionDigits = 0
        } else {
            numberFormatter.maximumFractionDigits = 1
        }
        formatter.numberFormatter = numberFormatter

        let result = formatter.string(from: distance)
        return result
    }

}
