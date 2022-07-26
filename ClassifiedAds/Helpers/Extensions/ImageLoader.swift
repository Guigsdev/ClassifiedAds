//
//  ImageLoader.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 24/07/2022.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func url(_ urlString: String) {self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return
        }

        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async { [weak self] in
                        self?.image = UIImage(named: "missing")
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                            self?.image = downloadedImage
                        } else {
                            self?.image = UIImage(named: "missing")
                        }
                    }
                }
            }).resume()
        }
    }
}
