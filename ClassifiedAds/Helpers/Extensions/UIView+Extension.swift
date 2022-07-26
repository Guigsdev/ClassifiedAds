//
//  UIView+Extension.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 23/07/2022.
//

import UIKit

extension UIView {
    func attachAnchors(to view: UIView, with insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left)
        ])
    }
}
