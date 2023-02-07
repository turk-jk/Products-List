//
//  ImageLoader.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    var urlString: String?
    
    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        if loadImageFromCache() {
            return
        }
        loadImageFromUrl()
    }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = urlString,
              let cacheImage = ImageCache.shared.get(for: urlString) else {
            return false
        }
        
        image = cacheImage
        return true
    }
    
    func loadImageFromUrl() {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
            .resume()
    }
    
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            return
        }
        guard let data = data else {
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data),
            let urlString = self.urlString else {
                return
            }
            
            ImageCache.shared.set(for: urlString, image: loadedImage)
            self.image = loadedImage
        }
    }
}
