//
//  ClassifiedAdViewModel.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 22/07/2022.
//

import Foundation
import Combine

enum ViewModelError: Error {
    case faildCategoriesLoading
    case faildItemsLoading

    var message: String {
        switch self {
        case .faildCategoriesLoading:
            return "Failed to load categories"
        case .faildItemsLoading:
            return "Failed to load classified ads from API"
        }
    }
}

final class ClassifiedAdViewModel {
    private let fetchItemsUseCase: FetchItemsUseCase
    private let fetchCategoriesUseCase: FetchCategoriesUseCase

    @Published private(set) var items: [ClassifiedAd] = []
    @Published private(set) var filteredItems: [ClassifiedAd] = []
    @Published private(set) var filters: [Category] = []

    @Published private(set) var state: ViewState = .loading
    private var subscriptions = Set<AnyCancellable>()

    var selectedCategory: Category?

    init(fetchItemsUseCase: FetchItemsUseCase,
         fetchCategoriesUseCase: FetchCategoriesUseCase) {
        self.fetchItemsUseCase = fetchItemsUseCase
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
    }

    func fetch() {
        fetchItems()
    }

    func fetchItems() {
        items.removeAll()
        fetchItemsUseCase.perform()
        .combineLatest(fetchCategoriesUseCase.perform())
        .sink { completion in
                if case .failure(let error) = completion {
                    print("error: \(error)")
                    self.state = .error(message: ViewModelError.faildItemsLoading.message)
                }
            } receiveValue: { newItems, categories in
                guard let receivedItems = newItems,
                      let receivedCategories = categories else { return }
                self.filters = receivedCategories
                let updatedItems = receivedItems.map {
                    return $0.updateCategoryName(name: self.getCategory(categoryId: $0.categoryId))
                }
                // sort items by date
                self.items = updatedItems.getUrgentItems() + updatedItems.getOptionalItems()
                self.state = .success

            }.store(in: &subscriptions)
    }

    func didUpdateCategory(category: Category) {
        selectedCategory = category
        let itemsByCategory = self.items.filter({$0.categoryId == selectedCategory?.id})
        filteredItems = itemsByCategory
    }

    func resetCategory() {
        selectedCategory = nil
        filteredItems.removeAll()
        fetch()
    }

    func getCategory(categoryId: Int) -> String{
        return filters.first(where: { categoryId == $0.id })?.name ?? ""
    }
}
