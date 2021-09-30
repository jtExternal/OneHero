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
        if url.absoluteString.hasSuffix(Configuration.imageNotAvailableSuffix) {
            Log.d("Detected Marvel API returned back no image. Using placeholder image instead.")
            DispatchQueue.main.async {
                completion(Assets.placeHolder.getImage())
            }
        } else if let cachedImage = DataCache.instance.readImageForKey(key: url.absoluteString) {
            Log.d("Loaded image from cache for \(url.absoluteString)")
            DispatchQueue.main.async {
                completion(cachedImage)
            }
        } else {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil, let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200, let data = data else {
                    // TODO Improve handling of these errors
                    if let err = error {
                        Log.e(err)
                    }
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                
                if let image = UIImage(data: data) {
                    Log.d("Writing new image to cache for key \(url.absoluteString)")
                    
                    DataCache.instance.write(image: image, forKey: url.absoluteString, format: .jpeg)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    Log.w("No image could be rendered.")
                    
                    DispatchQueue.main.async {
                        completion(UIImage())
                    }
                }
            }
            task.resume()
        }
    }
}
