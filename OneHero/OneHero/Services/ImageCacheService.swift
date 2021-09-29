//
//  ImageCacheService.swift
//  One Hero
//
//  Created by Justin Trantham on 9/29/21.
//

/*
 https://gist.github.com/reejosamuel/59841321a916e7c79bc2e91980fa32ac
 See LICENSE folder for this sample’s licensing information.
 Abstract:
 `ImageCacheManager` serves as a simple image cache for caching media artwork from a remote server.
 */

import Foundation
import UIKit
import DataCache

class ImageServiceHelper {
    func fetchImage(url: URL, completion: @escaping ((UIImage?) -> Void)) {
       
        // Read placeholder image
        if url.absoluteString.hasSuffix("image_not_available.jpg") {
            DispatchQueue.main.async {
                completion(Assets.placeHolder.getImage())
            }
        } else if let cachedImage = DataCache.instance.readImageForKey(key: url.absoluteString) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
        } else {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil, let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200, let data = data else {
                    // Your application should handle these errors appropriately depending on the kind of error.
                    
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    
                    return
                }
                
                
                if let image = UIImage(data: data) {
                    DataCache.instance.write(image: image, forKey: url.absoluteString, format: .jpeg)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(UIImage())
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
}
