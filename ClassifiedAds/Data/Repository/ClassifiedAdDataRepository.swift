//
//  ClassifiedAdDataRepository.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 22/07/2022.
//

import Foundation
import Combine

class ClassifiedAdDataRepository: ClassifiedAdRepository {

    private let classifiedAdService: ClassifiedAdAPIService

    init(service: ClassifiedAdAPIService) {
        self.classifiedAdService = service
    }

    func fetchItems() -> AnyPublisher<[ClassifiedAd]?, Error> {
        classifiedAdService.fetchItems()
    }

    func fetchCategories() -> AnyPublisher<[Category]?, Error> {
        classifiedAdService.fetchCategories()
    }
}
