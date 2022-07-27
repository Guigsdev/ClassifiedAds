//
//  Constants.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 26/07/2022.
//

import UIKit

enum Icons: String {
    case filterIcon
    case resetIcon
}

let isIpad = UIDevice.current.model.hasPrefix("iPad")

struct Fonts {

    static let listTitleFont: CGFloat = isIpad ? 18.0 : 15.0
    static let listCategoryFont: CGFloat = isIpad ? 15.0 : 12.0
    static let listPriceFont: CGFloat = isIpad ? 16.0 : 12.0

    static let detailTitleFont: CGFloat = isIpad ? 27.0 : 24.0
    static let detailCategoryFont: CGFloat = isIpad ? 20.0 : 16.0
    static let detailPriceFont: CGFloat = isIpad ? 20.0 : 16.0
    static let detailDescFont: CGFloat = isIpad ? 24.0 : 20.0
    static let detailDateFont: CGFloat = isIpad ? 17.0 : 14.0

    struct List {
        static let title = UIFont.boldSystemFont(ofSize: Fonts.listTitleFont)
        static let category = UIFont.systemFont(ofSize: Fonts.listCategoryFont, weight: .black)
        static let price = UIFont.systemFont(ofSize: Fonts.listPriceFont,
                                             weight: .black)
    }
    struct Detail {
        static let title = UIFont.boldSystemFont(ofSize: Fonts.detailTitleFont)
        static let category = UIFont.systemFont(ofSize: Fonts.detailCategoryFont, weight: .black)
        static let price = UIFont.systemFont(ofSize: Fonts.detailPriceFont,
                                             weight: .black)
        static let creationDate = UIFont.systemFont(ofSize: detailDateFont,
                                                    weight: .light)
        static let description = UIFont.systemFont(ofSize: Fonts.detailDescFont)
    }
}
