//
//  Date+Extension.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 27/07/2022.
//

import Foundation

extension Date {
    var toAdDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = .current
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter.string(from: self)
    }
}
