import Foundation

public extension Date {

    func removingTime(calendar: Calendar = Calendar.current) -> Date {
        return calendar.dateComponents([ .day, .month, .year, .timeZone, .calendar ], from: self).date!
    }

    func daysInterval(date: Date) -> Int {
        let seconds = self.removingTime().timeIntervalSince1970 - date.removingTime().timeIntervalSince1970

        let dateWithInterval = Date(timeIntervalSince1970: fabs(seconds))
        let value = Calendar.current.component(.day, from: dateWithInterval)-1 // we start at day 1, so we need to subtract it - 1/1/1970

        return seconds < 0 ? -value : value
    }

    static func later(date: Date?, than: Date?) -> Bool {
        guard let date = date else { return false }
        guard let than = than else { return true }

        return date > than
    }
}

