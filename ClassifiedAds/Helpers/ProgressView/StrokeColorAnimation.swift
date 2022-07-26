//
//  StrokeColorAnimation.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 23/07/2022.
//

import UIKit

class StrokeColorAnimation: CAKeyframeAnimation {

    override init() {
        super.init()
    }

    init(colors: [CGColor], duration: Double) {

        super.init()

        self.keyPath = "strokeColor"
        self.values = colors
        self.duration = duration
        self.repeatCount = .greatestFiniteMagnitude
        self.timingFunction = .init(name: .easeInEaseOut)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
