//
//  AlamofireNetworkService.swift
//
//

import Alamofire
import Combine
import Foundation

struct AlamofireNetworkService {
    static func defaultSession() -> Session {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60

        let session = Session(configuration: configuration)

        return session
    }

    private let sessionManager: Session
        init(with session: Session = defaultSession()) {
        sessionManager = session
    }
}

extension AlamofireNetworkService: NetworkServiceProtocols {
    func requestAPI<T: Codable, Response: Codable>(
        info: RequestInfo,
        params: T,
        decodable: Response.Type
    ) -> AnyPublisher<Response, NetworkServiceError> {

        let httpMethod: Alamofire.HTTPMethod = getHTTPMethod(info.httpMethod)

        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        var paramsEncoder: ParameterEncoder = JSONParameterEncoder(encoder: jsonEncoder)

        if httpMethod == Alamofire.HTTPMethod.get {
            let encoder = URLEncodedFormEncoder(keyEncoding: .convertToSnakeCase)
            paramsEncoder = URLEncodedFormParameterEncoder(encoder: encoder)
        }

        let afHeaders: Alamofire.HTTPHeaders? = convertHeaders(info.headers)

        let session = sessionManager
            .request(
                info.urlInfo,
                method: httpMethod,
                parameters: params,
                encoder: paramsEncoder,
                headers: afHeaders
            )

            .responseString { response in
                Logger.debug(response.result)
            }
            .validate(statusCode: 200..<300)
            .validate(contentType: [HTTPHeaderValue.applicationJson.rawValue])
            .publishData()
            .value()
            .tryMap { data -> Response in
                return try tryToCatchError(from: data)
            }
            .mapError { afError -> NetworkServiceError in
                Logger.debug(afError)
                if let afError = afError as? AFError {
                    switch afError.responseCode {
                    case .some(401):
                        return NetworkServiceError.authenError
                    case .some(409):
                        return NetworkServiceError.userExist
                    case .some:
                        return NetworkServiceError.unKnow
                    case .none:
                        return NetworkServiceError.unKnow
                    }
                } else {
                    return NetworkServiceError.unKnow
                }
            }

        return session.eraseToAnyPublisher()
    }

    private func tryToCatchError<R: Decodable>(from data: Data) throws -> R {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let result = try decoder.decode(R.self, from: data)
            return result
        } catch let error {
            print(error)
            let networkError = NetworkServiceError.decodeFailed
            throw networkError
        }
    }
}

extension AlamofireNetworkService {
    private func getHTTPMethod(_ method: HTTPMethod) -> Alamofire.HTTPMethod {
        var returnMethod: Alamofire.HTTPMethod

        switch method {
        case .get:
            returnMethod = Alamofire.HTTPMethod.get
        case .post:
            returnMethod = Alamofire.HTTPMethod.post
        case .put:
            returnMethod = Alamofire.HTTPMethod.put
        case .delete:
            returnMethod = Alamofire.HTTPMethod.delete
        }
        return returnMethod
    }

    private func convertHeaders(_ headers: HTTPHeader?) -> Alamofire.HTTPHeaders? {
        guard let headers: HTTPHeader = headers else {
            Logger.debug("Headers nil")
            return nil
        }

        return Alamofire.HTTPHeaders(headers)
    }
}
