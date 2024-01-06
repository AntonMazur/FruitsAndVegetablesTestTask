//
//  UIImageLoader.swift
//  iOS-Test
//
//  Created by Anton Mazur on 05.01.2024.
//

import UIKit

final class UIImageLoader {
    static let shared = UIImageLoader()
    
    private var imageLoader = ImageLoader()
    private var uuidMap: [UIImageView: UUID] = [:]
    
    private init() { }
    
    func load(with url: URL, for imageView: UIImageView) {
        let id = imageLoader.loadImage(url: url) { result in
            defer { self.uuidMap.removeValue(forKey: imageView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch {
                DispatchQueue.main.async {
                    imageView.image = .init(named: "noImage")
                }
            }
        }
        
        guard let id else { return }
        uuidMap[imageView] = id
    }
    
    func cancel(for imageView: UIImageView) {
        guard let uuid = uuidMap[imageView] else { return }
        imageLoader.cancelLoading(with: uuid)
        uuidMap.removeValue(forKey: imageView)
    }
}
