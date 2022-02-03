//
//  UIImageView + Fetching.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import UIKit
import Combine

extension UIImageView {
    func fetchImage(from url: URL?) -> AnyCancellable? {
        guard let url = url else {
            return nil
        }

        let cache = NSCache<NSString, UIImage>()
        
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            self.image = image
        } else if let image = URLCache().cachedResponse(for: URLRequest(url: url)).flatMap({ UIImage(data: $0.data) }) {
            self.image = image
        } else {
            return URLSession.shared.dataTaskPublisher(for: url)
                .retry(1)
                .compactMap { UIImage(data: $0.data) }
                .receive(on: OperationQueue.main)
                .sink(receiveCompletion: { _ in },
                      receiveValue: { [unowned self] image in
                    
                    self.image = image
                    
                    cache.setObject(image, forKey: url.absoluteString as NSString)
                })
        }
        
        return nil
    }
}
