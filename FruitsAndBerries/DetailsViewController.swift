//
//  DetailsViewController.swift
//  iOS-Test
//
//  Created by Anton Mazur on 06.01.2024.
//

import UIKit

struct DetailsViewModel {
    let image: Data?
    let name: String?
    let backgroundColor: UIColor?
    var description: String?
}

final class DetailsViewController: UIViewController {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var itemImageView: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    
    var detailsViewModel: DetailsViewModel!
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        setupUI()
    }
    
    private func setupUI() {
        title = detailsViewModel.name
        configureView(with: detailsViewModel)
        containerView.layer.cornerRadius = 20
    }
    
    private func configureView(with model: DetailsViewModel) {
        descriptionLabel.text = model.description
        guard let image = model.image else { return }
        itemImageView.image = .init(data: image)
        guard let backgroundColor = model.backgroundColor else { return }
        containerView.backgroundColor = backgroundColor
    }
}
    
