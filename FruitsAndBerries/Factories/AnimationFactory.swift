//
//  AnimationFactory.swift
//  iOS-Test
//
//  Created by Anton Mazur on 05.01.2024.
//

import UIKit

enum AnimationFactory {
    static func makeAnimation(duration: TimeInterval, delay: Double) -> Animation {
        return { tableView, cell, indexPath in
            cell.alpha = 0
            
            UIView.animate(withDuration: duration, delay: delay * Double(indexPath.section)) {
                cell.alpha = 1
            }
        }
    }
}
