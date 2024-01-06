//
//  AnimationManager.swift
//  iOS-Test
//
//  Created by Anton Mazur on 05.01.2024.
//

import UIKit

typealias Animation = (UITableView, UITableViewCell, IndexPath) -> Void

final class AnimationManager {
    private let animation: Animation
    private var areAllCellsAnimated = false
    
    init(animation: @escaping Animation) {
        self.animation = animation
    }
    
    func animate(in tableView: UITableView, for cell: UITableViewCell, at indexPath: IndexPath) {
        guard !areAllCellsAnimated else { return }
        animation(tableView, cell, indexPath)
        areAllCellsAnimated = tableView.isLastVisibleCell(at: indexPath)
    }
}

private extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else { return false }
        return lastIndexPath == indexPath
    }
}
