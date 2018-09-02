import Foundation

public extension String {

    var byteArray: [UInt8] {
        return Array(self.utf8)
    }

    var decodedBase64: String? {
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        let decodedString = String(data: decodedData, encoding: .utf8)
        return decodedString
    }

    var decodedBase64Alt: String? {
        let data = self.data(using: .utf8)
        guard let data64 = data?.base64EncodedData() else {
            return nil
        }
        return String(bytes: data64, encoding: .utf8)
    }

}

public extension Data {

    var stringRepresentation: String? {
        return String(bytes: self, encoding: .utf8)
    }

}
