//
//  ImageLoader.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/5/23.
//

import Foundation
import Combine
import SwiftUI


/*
 NOTE: Image Loader Support for SwiftUI
 */
class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<UIImage, Never>()
    @Published var image: UIImage? = UIImage()
    func loadImage(for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        RemoteImage.getImageFromCacheOrTask(url: url) { image in
            self.image = image
        }
    }
}
