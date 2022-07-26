//
//  Endpoint.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 20/07/2022.
//

import Foundation

/// This layer contains the Endpoint struct to be used later in the business logic layer for the creation of specific REST API base URLs and endpoints

enum HTTPRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

protocol Endpoint {

    /// The target's base `URL`.
    var baseURL: URL { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: HTTPRequestMethod { get }

    /// The headers to be used in the request.
    var headers: [String: String]? { get }

    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    var finalURL: URL {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = "\(baseURL.path)/\(path)"
        components.queryItems = !(queryItems?.isEmpty ?? false) ? queryItems : nil
        return components.url!
    }
}
