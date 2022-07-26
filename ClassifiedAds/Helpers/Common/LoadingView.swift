//
//  LoadingView.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 23/07/2022.
//

import UIKit

class LoadingView: UIView {

    private lazy var loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.red, .systemGreen, .systemBlue],
                                    lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .clear
        isHidden = true
        addSubview(loadingIndicator)
        addSubview(titleLabel)
        configureLayout()
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
                loadingIndicator.centerXAnchor
                    .constraint(equalTo: centerXAnchor),
                loadingIndicator.centerYAnchor
                    .constraint(equalTo: centerYAnchor),
                loadingIndicator.widthAnchor
                    .constraint(equalToConstant: 50),
                loadingIndicator.heightAnchor
                    .constraint(equalTo: self.loadingIndicator.widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 18),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func show() {
        isHidden = false
        loadingIndicator.isAnimating = true
    }

    func hide() {
        isHidden = true
        loadingIndicator.isAnimating = false
    }

}
