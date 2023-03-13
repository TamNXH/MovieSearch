//
//  BaseAPIFetcher.swift
//
//

import Foundation

class BaseAPIFetcher {
    public let networkService: NetworkService

    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }

    func apiURL(_ apiParams: String? = nil) -> URL? {
        fatalError("API URL must be override in child class")
    }

    func addDefaultParams(_ params: HTTPHeader) -> HTTPHeader {
        var returnParams = params

        returnParams.updateValue(HTTPHeaderValue.applicationJson.rawValue, forKey: HTTPHeaderField.acceptType.rawValue)
        returnParams.updateValue(
            HTTPHeaderValue.applicationJson.rawValue,
            forKey: HTTPHeaderField.acceptEncoding.rawValue
        )

        return returnParams
    }
}
