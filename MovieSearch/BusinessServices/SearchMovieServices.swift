//
//  SearchMovieServices.swift
//
//

import Combine
import Foundation

final class SearchMovieServices {
    private let searchAPIFetcher: SearchAPIFetcher

    init(searchAPIFetcher: SearchAPIFetcher = SearchAPIFetcher()) {
        self.searchAPIFetcher = searchAPIFetcher
    }

    func doLogin(param: SearchParam) -> AnyPublisher<SearchAPIEntity, AppServiceError> {
        guard let url = URL(string: ServerConstant.URLBase().baseAPIURL) else {
            return Fail(error: AppServiceError.urlError)
                .eraseToAnyPublisher()
        }
        let response = searchAPIFetcher.fetchSearchAPI(url, param: param)
            .mapError { error -> AppServiceError in
                switch error {
                case .authenError:
                    return AppServiceError.authenError
                default:
                    return AppServiceError.error
                }
            }
        return response.eraseToAnyPublisher()
    }

}
