//
//  NetworkService.swift
//
//

import Foundation
import Combine

struct NetworkService {
    private let networkService: NetworkServiceProtocols

    init(_ networkService: NetworkServiceProtocols = AlamofireNetworkService()) {
        // self.networkService = MockServerNetworkService()
        self.networkService = AlamofireNetworkService()
    }
}

extension NetworkService: NetworkServiceProtocols {
    func requestAPI<T: Codable, Response: Codable> (
        info: RequestInfo,
        params: T,
        decodable: Response.Type
    ) -> AnyPublisher<Response, NetworkServiceError> {
        return networkService.requestAPI(info: info, params: params, decodable: decodable)
    }
}
