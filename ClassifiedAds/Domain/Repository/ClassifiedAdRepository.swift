//
//  ClassifiedAdRepository.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 20/07/2022.
//

import Foundation
import Combine

protocol ClassifiedAdRepository {
    func fetchItems() -> AnyPublisher<[ClassifiedAd]?, Error>
    func fetchCategories() -> AnyPublisher<[Category]?, Error>
}
