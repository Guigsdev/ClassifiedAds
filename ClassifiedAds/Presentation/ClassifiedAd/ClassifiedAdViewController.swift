//
//  ClassifiedAdViewController.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 22/07/2022.
//

import Foundation
import UIKit
import Combine

class ClassifiedAdViewController: UIViewController, UITableViewDelegate {

    private let viewModel: ClassifiedAdViewModel
    private var coordinator: MainCoordinator
    private var subscriptions = Set<AnyCancellable>()

    private let itemsTableView = UITableView()
    private lazy var dataSource = makeDataSource()

    // MARK: - Properties
    private lazy var loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        loadingView.attachAnchors(to: (navigationController?.view)!)
        return loadingView
    }()

    init(viewModel: ClassifiedAdViewModel, coordinator: MainCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator

        super.init(nibName: nil, bundle: nil)
        bindUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func configureTableView() {
        itemsTableView.separatorStyle = .singleLine
        itemsTableView.backgroundColor = .lightGrayBackground
        itemsTableView.register(ClassifiedAdTableViewCell.self, forCellReuseIdentifier: ClassifiedAdTableViewCell.reuseIdentifier)
        itemsTableView.rowHeight = 120

        itemsTableView.translatesAutoresizingMaskIntoConstraints = false
        itemsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        itemsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        itemsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        itemsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        itemsTableView.dataSource = dataSource
        itemsTableView.delegate = self
    }

    private func bindUI() {
        viewModel.$items
            .receive(on: DispatchQueue.global(qos: .background))
            .sink { [unowned self] ads in
                self.updateData(with: ads)
            }.store(in: &subscriptions)

        viewModel.$filteredItems
            .receive(on: DispatchQueue.global(qos: .background))
            .sink { [unowned self] ads in
                self.updateData(with: ads)
            }.store(in: &subscriptions)

        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] state in
                self.render(state)
            }.store(in: &subscriptions)
    }

    private func render(_ state: ViewState) {
        switch state {
        case .loading:
            loadingView.show()
        case .error(let message):
            loadingView.hide()
        case .success:
            loadingView.hide()
        }
    }


    // MARK: - View Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        view.addSubview(itemsTableView)
        setupNavigationBarButtons()
        configureTableView()
        viewModel.fetch()
    }
}

extension ClassifiedAdViewController {

    private func setupNavigationBarButtons() {
        let filterBarButtonItem = UIBarButtonItem(image: UIImage(named: Icons.filterIcon.rawValue),
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(filterIconTapped))
        filterBarButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = filterBarButtonItem

        let resetBarButtonItem = UIBarButtonItem(image: UIImage(named: Icons.resetIcon.rawValue),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(resetIconTapped))
        resetBarButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = resetBarButtonItem
    }

    // MARK: - TableView
    private func makeDataSource() -> UITableViewDiffableDataSource<Int, ClassifiedAd> {
        return UITableViewDiffableDataSource<Int, ClassifiedAd>(tableView: itemsTableView, cellProvider: {tableView, indexPath, ad in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ClassifiedAdTableViewCell.reuseIdentifier, for: indexPath) as? ClassifiedAdTableViewCell else { fatalError("Cannot create news cell") }
            cell.configure(with: ad)
            return cell
        })
    }

    private func updateData(with items: [ClassifiedAd]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ClassifiedAd>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                guard let item = self.dataSource.itemIdentifier(for: indexPath) else { return }
                self.coordinator.displayItemDetail(with: item)
                tableView.isUserInteractionEnabled = true
            }
    }

    // MARK: - Actions
    @objc func filterIconTapped() {
        coordinator.displayFilter(with: viewModel)
    }

    @objc func resetIconTapped() {
        viewModel.resetCategory()
    }
}
