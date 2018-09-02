import Foundation

extension Data {

    var debugString: String {
        // Try to parse to json to debug
        if let jsonDict = try? JSONSerialization.jsonObject(with: self, options: .allowFragments) {
            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    return jsonString
                }
            }
        } else if let responseString = String(data: self, encoding: .utf8) {
            // Try to parse to string to debug
            return responseString
        }

        return ""
    }

}
