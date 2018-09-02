import Foundation

public extension URL {
    func queryParameter(param: String) -> String? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: false)

        let queryItems = components.flatMap { $0.queryItems }.map { $0 as [URLQueryItem] }

        let item = queryItems?.filter({ $0.name == param }).first

        return item?.value
    }

    func path(relativeTo basePath: String) -> String {
        return self.resolvingSymlinksInPath().path.replacingOccurrences(of: "^\(basePath)[/]", with: "", options: .regularExpression)
    }

}
