//
//  NetworkServiceProtocols.swift
//
//

import Foundation
import Combine

public protocol NetworkServiceProtocols {
    func requestAPI<
        T: Codable,
        Response: Codable
    >(
        info: RequestInfo,
        params: T,
        decodable: Response.Type
    ) -> AnyPublisher<Response, NetworkServiceError>
}
