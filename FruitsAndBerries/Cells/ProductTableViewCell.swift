//
//  ProductTableViewCell.swift
//  iOS-Test
//
//  Created by Anton Mazur on 05.01.2024.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
    static let cellId = "ProductTableViewCell"
    
    struct FruitModel {
        let name: String
        let backgroundColor: String
        let image: String?
    }

    @IBOutlet private var productName: UILabel!
    @IBOutlet private var productImage: UIImageView!
    
    override var frame: CGRect {
        get { super.frame }
        set {
            var frame = newValue
            let newWidth = frame.width * 0.8
            let spacing = (frame.width - newWidth) / 2
            
            frame.size.width = newWidth
            frame.origin.x = spacing
            
            super.frame = frame
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = true
        layer.cornerRadius = 15
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productName.text = nil
        productImage.image = nil
        productImage.cancelImageLoading()
    }
    
    func configure(with model: ProductTableViewCell.FruitModel) {
        productName.text = model.name
        backgroundColor = UIColor(rgb: model.backgroundColor)
        guard let url = NetworkManager.shared.getImageUrl(model.image) else {
            productImage.image = .init(named: "noImage")
            return
        }
        productImage.loadImage(for: url)
    }
    
    func getDetailsModel() -> DetailsViewModel {
        return DetailsViewModel(image: productImage.image?.pngData(),
                                name: productName.text,
                                backgroundColor: backgroundColor)
    }
}
