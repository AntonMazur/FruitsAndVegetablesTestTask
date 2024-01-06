//
//  Models.swift
//  iOS-Test
//
//  Created by Anton Mazur on 05.01.2024.
//

import Foundation

enum Models {
    // MARK: - ProductsModel
    struct ProductsModel: Decodable {
        let title: String
        let items: [Product]
    }

    struct Product: Decodable {
        let id, name, color: String
        let image: String?
    }
    
    // MARK: - Description Model
    struct DescriptionModel: Decodable {
        let id, text: String
    }
}
