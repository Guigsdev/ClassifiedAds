//
//  Coordinator.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 22/07/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
