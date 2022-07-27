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
    var creationDate: Date? = nil
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: CodingKeys.id)
        title = try container.decode(String.self, forKey: CodingKeys.title)
        categoryId = try container.decode(Int.self, forKey: CodingKeys.categoryId)
        if let dateString = try? container.decode(String.self, forKey: CodingKeys.creationDate), let date = dateString.toDate {
            creationDate = date
        }
        description = try container.decode(String.self, forKey: CodingKeys.description)
        isUrgent = try container.decode(Bool.self, forKey: CodingKeys.isUrgent)
        imagesUrl = try container.decode(ImagesURL.self, forKey: CodingKeys.imagesUrl)
        price = try container.decode(Float.self, forKey: CodingKeys.price)
        siret = try? container.decode(String.self, forKey: CodingKeys.siret)
        categoryName = nil
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
        return self.filter({$0.isUrgent}).sorted { ($0.creationDate ?? Date()) > ($1.creationDate ?? Date())}
    }

    func getOptionalItems() -> [ClassifiedAd] {
        return self.filter({!$0.isUrgent}).sorted { ($0.creationDate ?? Date()) > ($1.creationDate ?? Date()) }
    }
}
