//
//  ImageLoadService.swift
//  TestTask2023
//
//  Created by JkPhTrue Just on 05.01.2023.
//

import Foundation
import UIKit

protocol ImageLoadService {
    var cacheImageCountLimit: Int { get set }
    
    func loadImage(urlString: String, completion: @escaping ((UIImage?, Error?) -> Void))
}

class ImageLoadServiceImpl {
    
    private var cache = NSCache<NSString, UIImage>()
    private var task: URLSessionDataTask?
    
    private func loadImageFromUrlString(_ urlString: String, completion: @escaping ((UIImage?, Error?) -> Void)) {
        guard let url = URL(string: urlString) else {
            print("no url")
            return
        }
        
        task?.cancel()
        
        let request = URLRequest(url: url)
        
        task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data,
                   let uiImage = UIImage(data: data) {
                    self?.cache.setObject(uiImage, forKey: urlString as NSString)
                    completion(uiImage, nil)
                } else {
                    completion(nil, error)
                }
            }
        }
        
        task?.resume()
    }
}

extension ImageLoadServiceImpl: ImageLoadService {
    
    var cacheImageCountLimit: Int {
        get {
            return cache.countLimit
        }
        set {
            cache.countLimit = newValue
        }
    }
    
    func loadImage(urlString: String, completion: @escaping ((UIImage?, Error?) -> Void)) {
        if let image = cache.object(forKey: NSString(string: urlString)) {
            completion(image, nil)
            return
        }
        
        loadImageFromUrlString(urlString, completion: completion)
    }
}
