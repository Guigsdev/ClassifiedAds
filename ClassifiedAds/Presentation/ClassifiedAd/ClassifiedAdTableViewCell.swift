//
//  ClassifiedAdTableViewCell.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 22/07/2022.
//

import UIKit

class ClassifiedAdTableViewCell: UITableViewCell, CellReusable {

    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    let adImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()

    let emergencyImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.List.title
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.List.category
        label.textColor =  .white
        label.backgroundColor = .orange
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.List.price
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let backgroundView = UIView()
        backgroundView.backgroundColor = .orange
        selectedBackgroundView = backgroundView

        self.contentView.addSubview(adImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(categoryLabel)
        containerView.addSubview(emergencyImageView)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(priceLabel)

        configureContainerView()
        configureAdImageView()
        configureTitleLabel()
        configureCategoryLabel()
        configureEmergencyImage()
        configurePriceLabel()
    }

    private func configureContainerView() {
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.adImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-60).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:90).isActive = true
    }

    private func configureAdImageView() {
        adImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        adImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        adImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        adImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
    }

    private func configureTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
    }

    private func configureCategoryLabel() {
        categoryLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor, constant: 5).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
    }

    private func configureEmergencyImage() {
        emergencyImageView.image = UIImage(named: "emergency")
        emergencyImageView.topAnchor.constraint(equalTo:self.categoryLabel.bottomAnchor, constant: 5).isActive = true
        emergencyImageView.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true

        emergencyImageView.widthAnchor.constraint(equalToConstant:30).isActive = true
        emergencyImageView.heightAnchor.constraint(equalToConstant:26).isActive = true
    }

    private func configurePriceLabel() {
        priceLabel.heightAnchor.constraint(equalToConstant:26).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        adImageView.image = nil
    }

    func configure(with ad: ClassifiedAd) {
        titleLabel.text = ad.title.uppercased()
        categoryLabel.text = ad.categoryName
        priceLabel.text = ad.getPrice()
        emergencyImageView.isHidden = !ad.isUrgent
        guard let imageUrlString = ad.imagesUrl.small else {
            adImageView.image = UIImage(named: "missing")
            return
        }
        adImageView.url(imageUrlString)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }, completion: { finished in
                UIView.animate(withDuration: 0.2) {
                    self.transform = .identity
                }
            })
        }
    }
}
