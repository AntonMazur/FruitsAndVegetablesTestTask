//
//  LoaderView.swift
//  iOS-Test
//
//  Created by Anton Mazur on 05.01.2024.
//

import UIKit

@IBDesignable class LoaderViewWrapper : NibWrapperView<LoaderView> { }

final class LoaderView: UIView {
    @IBOutlet private var loaderImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startAnimation()
    }
    
    func startAnimation() {
        isHidden = false
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 4 * Double.pi
        rotation.duration = 1
        rotation.repeatCount = .infinity
        loaderImage.layer.add(rotation, forKey: "spin")
    }

    func stopAnimation() {
        isHidden = true
        loaderImage.layer.removeAllAnimations()
    }
}
