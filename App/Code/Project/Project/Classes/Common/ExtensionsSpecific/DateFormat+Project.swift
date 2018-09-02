import Foundation
import AFDateHelper

extension Date {

    var dateString: String? {
        let result = self.toString(format: DateFormatType.isoDate)
        return result
    }

    var timeString: String? {
        let result = self.toString(format: .custom("yyyy-MM-dd HH:mm:ss"))
        return result
    }

    var dateAndtimeString: String? {
        let components = [
            self.dateString,
            self.timeString
            ].compactMap {
                return $0
            }.map {
                return "\($0)"
        }
        let result = components.joined(separator: " · ")
        return result
    }

}

extension TimeInterval {
    var date: Date {
        return Date.init(timeIntervalSince1970: self)
    }

    var dateString: String? {
        return self.date.dateString
    }

    var timeString: String? {
        return self.date.timeString
    }

    var dateAndtimeString: String? {
        return self.date.dateAndtimeString
    }
}
