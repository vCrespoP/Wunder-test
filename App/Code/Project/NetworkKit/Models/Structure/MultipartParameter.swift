import Foundation

public struct MultipartParameter {
    public var data: Data
    public var fileParameter: MultipartFileParameter?

    public init(data: Data, fileParameter: MultipartFileParameter?) {
        self.data = data
        self.fileParameter = fileParameter
    }
}

extension MultipartParameter: AutoEquatableTRN, AutoHashableTRN { }

