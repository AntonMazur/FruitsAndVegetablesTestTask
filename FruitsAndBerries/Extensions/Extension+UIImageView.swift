//
//  Extension+UIImageView.swift
//  iOS-Test
//
//  Created by Anton Mazur on 05.01.2024.
//

import UIKit.UIImageView

extension UIImageView {
    func loadImage(for url: URL) {
        UIImageLoader.shared.load(with: url, for: self)
    }
    
    func cancelImageLoading() {
        UIImageLoader.shared.cancel(for: self)
    }
}
