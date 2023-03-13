//
//  NetworkServiceDefinations.swift
//
//

import Foundation
import Alamofire

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case apiVersion = "apiVersion"
}

public enum HTTPHeaderValue: String {
    case applicationJson = "application/json"
}

public enum APIError: Error {
    case encodeParamsFailed
    case decodeDataFailed
    case apiNotFound
    case apiError
    case authenError
    case userExist
}

public enum NetworkServiceError: Error {
    case serverError
    case authenError
    case encodeFailed
    case decodeFailed
    case userExist
    case unKnow
}

public typealias HTTPHeader = [String: String]

public struct RequestInfo {
    let urlInfo: URL
    let httpMethod: HTTPMethod
    let headers: HTTPHeader?

    init(urlInfo: URL, httpMethod: HTTPMethod, headers: HTTPHeader? = nil) {
        self.urlInfo = urlInfo
        self.httpMethod = httpMethod
        self.headers = headers
    }
}

public struct NetworkError: Error {
    let initialError: AFError?
}
