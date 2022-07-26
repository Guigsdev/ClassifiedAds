//
//  ClassifiedEndpoint.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 22/07/2022.
//

import Foundation

enum ClassifiedAdEndpoint {
    case fetchItems
    case fetchCategories
    
    struct Constants {
        static let baseUrl = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
        static let listing = "listing.json"
        static let categoryKey = "categories.json"
    }
}

extension ClassifiedAdEndpoint: Endpoint {
    var environmentBaseURL: String {
        return Constants.baseUrl
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .fetchItems:
            return Constants.listing

        case .fetchCategories:
            return Constants.categoryKey

        }
    }

    var method: HTTPRequestMethod {
        switch self {
        case .fetchItems, .fetchCategories:
            return .get
        }
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var headers: [String : String]? {
        switch self {
        case .fetchItems, .fetchCategories:
            return nil
        }
    }
}
