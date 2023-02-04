//
//  UIImageView+Extensions.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFrom(_ url: String, _ completion: @escaping () -> Void = {}) {
        guard let url = URL(string: url) else {
            return
        }
        if let cachedImage = GithubApplicationModule.cache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
            completion()
        } else {
            let operation = BlockOperation {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard error == nil else {
                        return
                    }
                    guard let httpURLResponse = response as? HTTPURLResponse,
                          httpURLResponse.statusCode == 200,
                          let data = data else {
                        return
                    }
                    DispatchQueue.main.async { [weak self] in
                        let image = UIImage(data: data)
                        self?.image = image
                        completion()
                        GithubApplicationModule.cache.setObject(image!, forKey: url.absoluteString as NSString)
                    }
                }.resume()
            }
            GithubApplicationModule.operationQueue.addOperation(operation)
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
