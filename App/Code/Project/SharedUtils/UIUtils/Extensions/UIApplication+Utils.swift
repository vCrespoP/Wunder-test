import UIKit
import MapKit

public extension UIApplication {
    static let phoneCallScheme = "tel"

    public static var canMakePhoneCalls: Bool {
        guard let url = URL(string: "\(phoneCallScheme)://") else { return false }

        return self.shared.canOpenURL(url)
    }

    //    public static func call(phoneNumber: String) -> Bool {
    //        if let phoneCallURL = URL(string: "\(phoneCallScheme)://" + phoneNumber) {
    //            let application = UIApplication.shared
    //            if application.canOpenURL(phoneCallURL) {
    //                application.openURL(phoneCallURL)
    //                return true
    //            }
    //        }
    //        return false
    //    }

    //    public static func open(urlString: String?) {
    //        guard let urlString = urlString, let url = URL(string: urlString) else { return }
    //
    //        UIApplication.shared.openURL(url)
    //    }

    public static func openMaps(latitude: Double, longitude: Double, name: String?) {
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: nil)
    }

    //    public static func sendEmail(to: String?, cc: [String], subject: String?, body: String?) {
    //
    //        func escape(_ string: String) -> String? {
    //            return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    //        }
    //
    //        var components = URLComponents()
    //        components.scheme = "mailto"
    //        components.host = to.flatMap(escape)
    //        components.queryItems = [
    //            URLQueryItem(name: "cc", value: cc.map(escape).compactMap{$0}.joined(separator: ",")),
    //            URLQueryItem(name: "subject", value: subject.flatMap(escape)),
    //            URLQueryItem(name: "body", value: body.flatMap(escape))
    //        ]
    //
    //        guard let mailUrl = components.url else {
    //            return
    //        }
    //
    //        if UIDevice.isSimulator {
    //            print("*Running in simulator* \(mailUrl)")
    //        }
    //
    //        UIApplication.shared.openURL(mailUrl)
    //    }

    static func share(text: String?, image: UIImage?, url: URL?, excludedActivities: [UIActivityType] = []) -> UIActivityViewController {

        let objects: [Any?] = [ text, image, url ]
        let objectsToShare: [Any] = objects.compactMap { $0 }

        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

        activityVC.excludedActivityTypes = excludedActivities

        return activityVC
    }

}
