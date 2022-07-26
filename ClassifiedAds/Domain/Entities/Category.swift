//
//  category.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 19/07/2022.
//

import Foundation

struct Category: Decodable, Hashable {
    let id: Int
    let name: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
