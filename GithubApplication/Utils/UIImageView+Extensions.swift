//
//  UIImageView+Extensions.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFrom(_ url: String,_ completion: @escaping () -> Void = {}, _ dataCompletion: @escaping (Data) -> Void = { _ in } ) {
        guard let url = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return
            }
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let data = data else {
                return
            }
            dataCompletion(data)
            DispatchQueue.main.async { [weak self] in
                let image = UIImage(data: data)
                self?.image = image
                completion()
            }
        }.resume()
    }
    func loadFrom(_ data: Data) {
        DispatchQueue.main.async { [weak self] in
            let image = UIImage(data: data)
            self?.image = image
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
