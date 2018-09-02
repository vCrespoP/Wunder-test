// MARK: Public Methods
public extension Bundle {

    func resourceUrl(fileName: String) -> URL? {
        let (name, ext) = split(fileName: fileName)

        return self.url(forResource: name, withExtension: ext)
    }

    func resourceUrl(name: String, extension ext: String) -> URL? {
        return self.url(forResource: name, withExtension: ext)
    }

    func read(resourceName: String) -> String? {
        let (name, ext) = split(fileName: resourceName)
        return read(resourceName: name, extension: ext)
    }

    func read(resourceName: String, extension ext: String) -> String? {
        guard let url = self.resourceUrl(name: resourceName, extension: ext) else {
            return nil
        }

        return try? String(contentsOf: url)
    }

    var versionNumber: String? {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildNumber: String? {
        return self.infoDictionary?["CFBundleVersion"] as? String
    }

    var versionFormatted: String? {
        let result = "v. \(self.versionNumber!) (\(self.buildNumber!))"
        return result
    }

}

// MARK: Private Methods
extension Bundle {

    fileprivate func split(fileName: String) -> (String, String) {
        let url = URL(fileURLWithPath: fileName)

        let name = url.deletingPathExtension().relativePath
        let ext = url.pathExtension

        return (name, ext)
    }

}
