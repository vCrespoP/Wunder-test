import Foundation

public extension String {

    var length: Int {
        return self.count
    }

    var localized: String {
        guard !isBlank(self) else { return self }

        return NSLocalizedString(self,
                                 tableName: nil,
                                 bundle: Bundle.main,
                                 value: self,
                                 comment: self)
    }

    var url: URL? {
        return URL(string: self)
    }
}

