//
//  Extension+UIView.swift
//  iOS-Test
//
//  Created by Anton Mazur on 05.01.2024.
//

import UIKit.UIView

extension UIView {
    static func loadFromNib() -> Self {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: String(describing: self), bundle: bundle)
        return nib.instantiate(withOwner: nil).first as! Self
    }
}
