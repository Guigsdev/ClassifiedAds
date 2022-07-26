//
//  DetailViewController.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 26/07/2022.
//

import UIKit
import Combine

class ClassifiedAdDetailViewController: UIViewController {
    private let viewModel: ClassifiedAdDetailViewModel
    private var coordinator: MainCoordinator

    private var subscriptions = Set<AnyCancellable>()

    init(viewModel: ClassifiedAdDetailViewModel, coordinator: MainCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        bindUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.viewDidLoad()
    }

    private func bindUI() {
        viewModel.itemSubject
            .sink { [unowned self] item in
                self.updateUI(with: item)
            }.store(in: &subscriptions)
    }

    private func updateUI(with item: ClassifiedAd) {

    }
}
