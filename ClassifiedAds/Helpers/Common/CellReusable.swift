//
//  CellReusable.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 24/07/2022.
//

import UIKit

protocol CellReusable {
    static var reuseIdentifier: String { get }
}

extension CellReusable where Self: UIView {
    static var reuseIdentifier: String {
        get {
            return String(describing: self)
        }
    }
}
