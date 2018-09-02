import Foundation

import SharedUtils

public protocol NetworkService {

    var baseUrl: URL { get }

    init(baseUrl: URL)

    typealias Log = (String) -> ()
    typealias CompletionHandler<T> = (_ result: NetworkResponse<T?>) -> Void
    typealias CancelRequest = () -> Void

    @discardableResult func request(
        _ request: Request,
        log: @escaping Log,
        completion: @escaping CompletionHandler<Data>
        ) -> CancelRequest

}

public extension NetworkService {

    @discardableResult func request<T: Decodable>(
        _ request: Request,
        log: @escaping Log,
        completion: @escaping CompletionHandler<T>
        ) -> CancelRequest {

        return self.request(request, log: log, completion: { networkResponse in

            switch networkResponse {

            case .success(let data, let response):
                do {
                    let dataParsed = try T.parse(from: data)
                    let finalResponse = NetworkResponse.success(dataParsed, response)
                    completion(finalResponse)
                } catch let error {
                    let finalResponse: NetworkResponse<T?> = NetworkResponse.encodingError(error)
                    completion(finalResponse)
                }

            case .encodingError(let errror):
                let finalResponse: NetworkResponse<T?> = NetworkResponse.encodingError(errror)
                completion(finalResponse)

            case .networkError(let responseError, let response):
                let finalResponse: NetworkResponse<T?> = NetworkResponse.networkError(responseError, response)
                completion(finalResponse)
            }

        })

    }

}
