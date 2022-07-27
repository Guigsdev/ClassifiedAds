//
//  FilterViewController.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 25/07/2022.
//


import UIKit
import Combine

class FilterViewController : UIViewController, UITableViewDelegate {
    enum Section: String, CaseIterable {
        case category = "Select Category"
    }

    private let viewModel: ClassifiedAdViewModel
    private let filterTableView = UITableView()
    private let cellIdentifier = "FilterCell"
    private lazy var dataSource = makeDataSource()
    private var subscriptions = Set<AnyCancellable>()

    private let okButton = UIButton(type: .custom)

    var selectedCategory: Category?

    // MARK: - Init
    init(viewModel: ClassifiedAdViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.35)
        view.addSubview(filterTableView)
        view.addSubview(okButton)
        configureTableView()
        configureOKButton()
        bindUI()
        filterTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        filterTableView.dataSource = dataSource
        filterTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedCategory = viewModel.selectedCategory
    }
}

extension FilterViewController {
    private func configureTableView() {
        filterTableView.separatorStyle = .singleLine
        filterTableView.backgroundColor = .white
        filterTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        filterTableView.translatesAutoresizingMaskIntoConstraints = false
        filterTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        filterTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        filterTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
      }

    private func configureOKButton() {
        okButton.backgroundColor = .orange
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        okButton.setTitle("Validate", for: .normal)
        okButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.topAnchor.constraint(equalTo:self.filterTableView.bottomAnchor, constant: 0).isActive = true
        okButton.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        okButton.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        okButton.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        okButton.heightAnchor.constraint(equalToConstant:60).isActive = true
    }

    private func bindUI() {
        viewModel.$filters
            .sink { [unowned self] categories in
                self.updateData(with: categories)
            }.store(in: &subscriptions)
    }

    // MARK: UITableView
    private func makeDataSource() -> DataSource {
        let myDatasource =
        DataSource(tableView: filterTableView) { tableView, indexPath, itemIdentifier in
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .category:
                let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
                guard let category = itemIdentifier as? Category else { fatalError("Cannot create category cell")}

                var content = cell.defaultContentConfiguration()
                content.text = category.name
                cell.contentConfiguration = content
                cell.accessoryType = category.id == self.selectedCategory?.id ? .checkmark : .none
                cell.selectionStyle = .none
                return cell
            }
        }
        return myDatasource
    }

    private func updateData(with categories: [Category]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([Section.category])
        snapshot.appendItems(categories, toSection: .category)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = Section.allCases[indexPath.section]
        switch sectionType {
        case .category:
            selectedCategory = viewModel.filters[indexPath.row]
        }

        tableView.reloadData()
    }

    @IBAction private func okButtonAction(_ sender: UIButton) {
        if let selectedCateg = selectedCategory {
            viewModel.didUpdateCategory(category: selectedCateg)
        }
        dismiss(animated: true, completion: nil)
    }
}

class DataSource: UITableViewDiffableDataSource<FilterViewController.Section, AnyHashable>  {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FilterViewController.Section.allCases[section].rawValue
    }
}
