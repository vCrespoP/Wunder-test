import Foundation

public protocol AutoEquatable { }
public protocol AutoHashable { }
public protocol AutoCases { }
public protocol ProtocolNameMock { }
public protocol AutoDiffable { }
public protocol AutoLenses { } // Not used
public protocol AutoMapper { }

protocol AutoBuilder { }
protocol AutoHashableTRN { }
protocol AutoHashableTRN2 { }
protocol AutoEquatableTRN { }

protocol BuilderProtocol {
    typealias BuilderClosure = (inout Self) -> Void
    init(with: BuilderClosure)
}
