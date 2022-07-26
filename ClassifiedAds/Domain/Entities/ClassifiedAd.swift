//
//  ClassifiedAd.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 19/07/2022.
//

import Foundation

struct ClassifiedAd: Decodable, Hashable {
    let id: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Float
    let imagesUrl: ImagesURL
    let creationDate: String
    let isUrgent: Bool
    let siret: String?
    var categoryName: String?

    enum CodingKeys: String, CodingKey {
        case id, title, description, price
        case categoryId = "category_id"
        case imagesUrl = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
        case categoryName
    }

    static func == (lhs: ClassifiedAd, rhs: ClassifiedAd) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    func getPrice() -> String {
        return String(format: "%.f€", price)
    }
}

extension ClassifiedAd {
    func updateCategoryName(name: String) -> ClassifiedAd {
        var ad = self
        ad.categoryName = "  \(name)  "
        return ad
    }
}

extension Array where Element == ClassifiedAd {

    func getUrgentItems() -> [ClassifiedAd] {
        return self.filter ({ $0.isUrgent}).sorted {$0.creationDate.compare($1.creationDate, options: .numeric) == .orderedDescending}
    }

    func getOptionalItems() -> [ClassifiedAd] {
        return self.filter ({ !$0.isUrgent}).sorted {$0.creationDate.compare($1.creationDate, options: .numeric) == .orderedDescending}
    }
}
