import Foundation

import RxSwift

public extension Observable {
    static func `catch`(_ f: () throws -> (Element)) -> Observable {
        do {
            let result = try f()
            return Observable.just(result)
        }
        catch let error {
            return Observable.error(error)
        }
    }

    static func nilToError(_ error: Error, _ f: () -> (Element?)) -> Observable {
        guard let result = f() else {
            return Observable.error(error)
        }

        return Observable.just(result)
    }

    typealias MapError = (Swift.Error) -> Error
    func mapError(_ f: @escaping MapError) -> Observable<E> {
        return self.catchError { error in
            return Observable.error(f(error))
        }
    }
}
