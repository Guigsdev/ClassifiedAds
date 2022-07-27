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

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = Fonts.Detail.title
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        return titleLabel
    }()

    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = .black
        priceLabel.font = Fonts.Detail.price
        priceLabel.textAlignment = .right
        return priceLabel
    }()

    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .black
        dateLabel.font = Fonts.Detail.creationDate
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()

    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.textColor =  .white
        categoryLabel.backgroundColor = .orange
        categoryLabel.layer.cornerRadius = 5
        categoryLabel.clipsToBounds = true
        categoryLabel.font = Fonts.Detail.category
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoryLabel
    }()

    private lazy var emergencyImageView: UIImageView = {
        let emergencyImageView = UIImageView()
        emergencyImageView.translatesAutoresizingMaskIntoConstraints = false
        emergencyImageView.contentMode = .scaleAspectFit
        return emergencyImageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.font = Fonts.Detail.description
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: .vertical)
        return descriptionLabel
    }()

    /// A container view used to arrange content within the `scrollView`.
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    /// An `UIScrollView` used to make the page scrollable. Only has a single child, `containerView`.
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    init(viewModel: ClassifiedAdDetailViewModel, coordinator: MainCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        setupUI()
        bindUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewDidLoad()
    }
}

extension ClassifiedAdDetailViewController {

    private func setupUI() {
        scrollView.backgroundColor = .white
        scrollView.clipsToBounds = true
        addSubviews()
        configureSubviews()
    }

    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(categoryLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(emergencyImageView)
        containerView.addSubview(descriptionLabel)
    }

    private func configureSubviews() {
        configureScrollView()
        configureContainerView()
        configureImageView()
        configureTitleLabel()
        configureDateLabel()
        configureCategoryLabel()
        configurePriceLabel()
        configureEmergencyLabel()
        configureDescriptionLabel()
    }

    private func configureScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func configureContainerView() {
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }


    private func configureImageView() {
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }

    private func configureTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
    }

    private func configurePriceLabel() {
        priceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
    }

    private func configureDateLabel() {
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: priceLabel.heightAnchor).isActive = true
    }

    private func configureCategoryLabel() {
        categoryLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        categoryLabel.heightAnchor.constraint(equalTo: priceLabel.heightAnchor).isActive = true
    }

    private func configureEmergencyLabel() {
        emergencyImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8).isActive = true
        emergencyImageView.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 12).isActive = true
        emergencyImageView.widthAnchor.constraint(equalToConstant:30).isActive = true
        emergencyImageView.heightAnchor.constraint(equalToConstant:26).isActive = true
    }

    private func configureDescriptionLabel() {
        descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 12).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
    }

    /// setup the UI by binding to view model
    private func bindUI() {
        viewModel.itemSubject
            .sink { [unowned self] item in
                self.updateUI(with: item)
            }.store(in: &subscriptions)
    }

    /// Called by the viewModel when item is prepared to refresh the UI
    private func updateUI(with item: ClassifiedAd) {
        titleLabel.text = item.title.uppercased()
        dateLabel.text = item.creationDate?.toAdDateString.uppercased() ?? ""
        categoryLabel.text = item.categoryName
        priceLabel.text = item.getPrice()
        emergencyImageView.image = item.isUrgent ? UIImage(named: "emergency") : nil
        descriptionLabel.text = item.description

        guard let imageUrlString = item.imagesUrl.thumb else {
            imageView.image = UIImage(named: "missing")
            return
        }
        imageView.url(imageUrlString)
        imageView.sizeToFit()
    }
}
