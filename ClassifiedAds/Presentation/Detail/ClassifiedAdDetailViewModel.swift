//
//  DetailViewModel.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 26/07/2022.
//

import Foundation
import Combine

final class ClassifiedAdDetailViewModel {

    private let item: ClassifiedAd
    private(set) var itemSubject = PassthroughSubject<ClassifiedAd, Never>()

    init(with item: ClassifiedAd) {
        self.item = item
    }

    func viewDidLoad() {
        itemSubject.send(item)
    }

}
