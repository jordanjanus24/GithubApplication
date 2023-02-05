//
//  ImageLoader.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/5/23.
//

import Foundation
import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<UIImage, Never>()
    @Published var image: UIImage? = UIImage()

    func loadImage(for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if let cachedImage = GithubApplicationModule.cache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            let operation = BlockOperation {
                RemoteImage.getImageFromTask(url: url) { [weak self] image in
                    self?.image = image
                    GithubApplicationModule.cache.setObject(image!, forKey: url.absoluteString as NSString)
                }.resume()
            }
            GithubApplicationModule.operationQueue.addOperation(operation)
        }
    }
}
