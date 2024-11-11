//
//  ImageCacheManager.swift
//  Devskiller
//
//  Created by Fernando Cani on 10/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()

    static func fetchImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = shared.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        if #available(iOS 15.0, *) {
            Task {
                do {
                    let imageData = try await URLSession.shared.data(from: url).0
                    if let image = UIImage(data: imageData) {
                        shared.setObject(image, forKey: urlString as NSString)
                        DispatchQueue.main.async {
                            completion(image)
                        }
                    } else {
                        completion(nil)
                    }
                } catch {
                    print("Error downloading image: \(error)")
                    completion(nil)
                }
            }
        } else {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    shared.setObject(image, forKey: urlString as NSString)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                }
            }.resume()
        }
    }
}
