//
//  UIImageView+Extensions.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation
import UIKit


protocol RemoteImageProtocol {
    static func getImageFromTask(url: URL, _ completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask
    static func getImageFromCacheOrTask(url: URL, _ completion: @escaping (UIImage?) -> Void)
}

class RemoteImage: RemoteImageProtocol {
    static func getImageFromTask(url: URL, _ completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return
            }
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let data = data else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                completion(image)
            }
        }
    }
    static func getImageFromCacheOrTask(url: URL, _ completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = GithubApplicationModule.cache.object(forKey: url.absoluteString as NSString) as? UIImage {
            completion(cachedImage)
        } else {
            let operation = BlockOperation {
                RemoteImage.getImageFromTask(url: url) { image in
                    completion(image)
                    GithubApplicationModule.cache.setObject(image!, forKey: url.absoluteString as NSString)
                }.resume()
            }
            GithubApplicationModule.operationQueue.addOperation(operation)
        }
    }
}
extension UIImageView {
    func loadFrom(_ url: String, placeHolder: String, _ completion: @escaping () -> Void = {}) {
        self.image = nil
        guard let url = URL(string: url) else {
            return
        }
        RemoteImage.getImageFromCacheOrTask(url: url) { [weak self] image in
            if let image = image {
                self?.image = image
            } else {
                self?.image = nil
            }
        }
    }
    func invertImageColor() {
        let coreImage = CIImage(image: self.image!)
        guard let filter = CIFilter(name: "CIColorInvert") else {
            return
        }
        filter.setValue(coreImage, forKey: kCIInputImageKey)
        guard let result = filter.value(forKey: kCIOutputImageKey) as? CIImage else {
            return
        }
        self.image = UIImage(cgImage: CIContext(options: nil).createCGImage(result, from: result.extent)!)
    }
}
