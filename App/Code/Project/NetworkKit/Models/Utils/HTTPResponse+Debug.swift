import Foundation

extension HTTPResponse: CustomDebugStringConvertible {

    public var debugDescription: String {

        let responseTitleString = "\n ****** Response:"
        let responseCodeString = "-- Status Code: \(self.responseCode)"
        let urlString = "-- Received from: \(self.url.absoluteString)"
        let dataString = "-- Response: \(self.data?.debugString ?? "-")"
        let components: [String] = [
            responseTitleString,
            responseCodeString,
            urlString,
            dataString
        ]
        let result = components.joined(separator: "\n")
        return result
    }

}
