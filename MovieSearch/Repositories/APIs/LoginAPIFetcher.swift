//
//  LoginAPIFetcher.swift
//
//

import Foundation
import Combine

final class SearchAPIFetcher {
    public let networkService: NetworkService

    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
}

extension SearchAPIFetcher {
    func fetchSearchAPI(_ url: URL, param: SearchParam) -> AnyPublisher<SearchAPIEntity, APIError> {
        let request = RequestInfo(urlInfo: url, httpMethod: .get)

        let apiResponse = networkService.requestAPI(info: request, params: param, decodable: SearchAPIEntity.self)
            .mapError { networkError -> APIError in
                switch networkError {
                case .authenError:
                    return APIError.authenError
                default:
                    return APIError.apiError
                }
            }
            .eraseToAnyPublisher()
        return apiResponse.eraseToAnyPublisher()
    }
}
