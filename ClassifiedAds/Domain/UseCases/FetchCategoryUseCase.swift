//
//  FetchCategoryUseCase.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 20/07/2022.
//

import Foundation
import Combine

protocol FetchCategoriesUseCaseProtocol {
    func perform() -> AnyPublisher<[Category]?, Error>
}

final class FetchCategoriesUseCase: FetchCategoriesUseCaseProtocol {

    private let classifiedAdRepository: ClassifiedAdRepository

    init(repository: ClassifiedAdRepository) {
        self.classifiedAdRepository = repository
    }

    func perform() -> AnyPublisher<[Category]?, Error> {
        classifiedAdRepository.fetchCategories()
    }
}
