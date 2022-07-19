//
//  ClassifiedAd.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 19/07/2022.
//

import Foundation

struct ClassifiedAd: Decodable {
    let id: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Float
    let imagesUrl: ImagesURL
    let creationDate: String
    let isUrgent: Bool
    let siret: String?
}
