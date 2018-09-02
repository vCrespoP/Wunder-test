import Foundation

import Domain
import NetworkKit
import NetworkSpecific
import RxSwift

class ApiUtils {

    static func apiRequest<T: Decodable>(networkService: NetworkService, request: Request, logger: Logger) -> Observable<SuccessResponse<T>> {

        return Observable.create { observable in

            let cancellableRequest = networkService.request(
                request,
                log: { logText in

                    logger.debug(logText)

            }, completion: { (networkResponse: NetworkResponse<T?>) in

                switch networkResponse {

                case .success(let apiResponse, let httpResponse):
                    guard let apiResponse = apiResponse else {
                        let errorResponse = ErrorResponse.noData(statusCode: httpResponse.responseCode)
                        observable.onError(errorResponse)
                        return
                    }

                    observable.onNext(SuccessResponse(data: apiResponse, statusCode: httpResponse.responseCode))
                    observable.onCompleted()

                case .networkError(let responseError, let httpResponse):

                    logger.error("* Network error: \(responseError)")

                    do {
                        guard var errorResponse = try ErrorResponse.parse(from: httpResponse.data) else {
                            let error = ErrorResponse.encoding(statusCode: httpResponse.responseCode)
                            observable.onError(error)
                            return
                        }
                        errorResponse.statusCode = httpResponse.responseCode
                        observable.onError(errorResponse)
                    } catch {
                        let error = ErrorResponse.encoding(statusCode: httpResponse.responseCode)
                        observable.onError(error)
                    }

                case .encodingError(let error):

                    logger.error("* Encoding error: \(error)")

                    let errorResponse = ErrorResponse.encoding()
                    observable.onError(errorResponse)

                }
            })

            return Disposables.create {
                cancellableRequest()
            }

        }

    }

    static func downloadRequest(networkService: NetworkService, request: Request, logger: Logger) -> Observable<Data> {
        return Observable.create { observable in

            let cancellableRequest = networkService.request(
                request,
                log: { logger.debug($0) },
                completion: { (networkResponse: NetworkResponse<Data?>) in

                    switch networkResponse {
                    case .success(.some(let data), _):
                        observable.onNext(data)
                        observable.onCompleted()
                    case .success:
                        observable.onError(ErrorResponse.noData())
                    case .networkError(let responseError, let httpResponse):
                        logger.error("* Network error: \(responseError)")
                        let error = ErrorResponse.encoding(statusCode: httpResponse.responseCode)
                        observable.onError(error)

                    case .encodingError(let error):
                        logger.error("* Encoding error: \(error)")

                        let errorResponse = ErrorResponse.encoding()
                        observable.onError(errorResponse)

                    }
            })

            return Disposables.create {
                cancellableRequest()
            }

        }
    }

}

extension ErrorResponse {

    static func encoding(statusCode: Int = 9999) -> ErrorResponse {
        return ErrorResponse(statusCode: statusCode)
    }

    static func noData(statusCode: Int = 9999) -> ErrorResponse {
        return ErrorResponse(statusCode: statusCode)
    }

}
