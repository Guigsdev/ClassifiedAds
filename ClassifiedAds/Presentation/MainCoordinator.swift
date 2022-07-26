//
//  MainCoordinator.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 22/07/2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let service = ClassifiedAdAPIService()
        let classifiedAdRepository = ClassifiedAdDataRepository(service: service)
        let fetchItemsUseCase = FetchItemsUseCase(repository: classifiedAdRepository)
        let fetchCategoriesUseCase = FetchCategoriesUseCase(repository: classifiedAdRepository)
        let viewModel = ClassifiedAdViewModel(fetchItemsUseCase: fetchItemsUseCase, fetchCategoriesUseCase: fetchCategoriesUseCase)
        let classifiedAdVC = ClassifiedAdViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(classifiedAdVC, animated: false)
    }

    func displayItemDetail(with item: ClassifiedAd) {
        let viewModel =  ClassifiedAdDetailViewModel(with: item)
        let classifiedAdDetailVC = ClassifiedAdDetailViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(classifiedAdDetailVC, animated: true)
    }

    func displayFilter(with viewModel: ClassifiedAdViewModel) {
        let filterVC = FilterViewController(viewModel: viewModel)
        filterVC.modalPresentationStyle = .overCurrentContext
        navigationController.present(filterVC, animated: true, completion: nil)
    }

}
