//
//  Extension+UITableView.swift
//  iOS-Test
//
//  Created by Anton Mazur on 05.01.2024.
//

import UIKit.UITableView

extension UITableView {
    func showEmptyView() {
        guard let width = superview?.bounds.size.width, let height = superview?.bounds.size.height else { return }
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        emptyLabel.numberOfLines = 0
        emptyLabel.text = "An error occured while loading a list.\nPlease, try again later! 🙂"
        emptyLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        emptyLabel.textAlignment = NSTextAlignment.center
        backgroundView = emptyLabel
    }
    
    func removeEmptyView() {
        backgroundView = nil
    }
}
