//
//  FetchItemsUseCase.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 20/07/2022.
//

import Foundation
import Combine

protocol FetchItemsUseCaseProtocol {
    func perform() -> AnyPublisher<[ClassifiedAd]?, Error>
}

final class FetchItemsUseCase: FetchItemsUseCaseProtocol {

    private let classifiedAdRepository: ClassifiedAdRepository

    init(repository: ClassifiedAdRepository) {
        self.classifiedAdRepository = repository
    }

    func perform() -> AnyPublisher<[ClassifiedAd]?, Error> {
        classifiedAdRepository.fetchItems()
    }
}
