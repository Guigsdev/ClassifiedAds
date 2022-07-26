//
//  ClassifiedAdAPIServiceProtocol.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 22/07/2022.
//

import Foundation
import Combine

protocol ClassifiedAdAPIServiceProtocol {
    func fetchItems() -> AnyPublisher<[ClassifiedAd]?, Error>
    func fetchCategories() -> AnyPublisher<[Category]?, Error>

}

struct ClassifiedAdAPIService: APIClient, ClassifiedAdAPIServiceProtocol {
    func fetchItems() -> AnyPublisher<[ClassifiedAd]?, Error> {
        fetch(endpoint: ClassifiedAdEndpoint.fetchItems)
    }

    func fetchCategories() -> AnyPublisher<[Category]?, Error> {
        fetch(endpoint: ClassifiedAdEndpoint.fetchCategories)
    }
}
