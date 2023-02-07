//
//  ImageCache.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import UIKit

class ImageCache {
    static var shared = ImageCache()
    
    var cache = NSCache<NSString, UIImage>()
    
    func get(for key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }
    
    func set(for key: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}

