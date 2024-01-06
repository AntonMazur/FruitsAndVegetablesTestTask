//
//  NetworkManager.swift
//  iOS-Test
//
//  Created by Anton Mazur on 05.01.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private enum Endpoint {
        case items(String)
        case images(String)
        case description(String)
        
        var url: String {
            let baseURL = "https://test-task-server.mediolanum.f17y.com"
            
            switch self {
            case .items(let parameter):
                return baseURL + "/items/" + parameter
            case .images(let parameter):
                return baseURL + parameter
            case .description(let parameter):
                return baseURL + "/texts/" + parameter
            }
        }
    }
    
    private init() { }
    
    func getProducts(for item: String) async throws -> Models.ProductsModel? {
        let loadingTask = Task { () -> Models.ProductsModel? in
            guard let url = URL(string: Endpoint.items(item).url), !Task.isCancelled else { return nil }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(Models.ProductsModel.self, from: data)
            return decodedData
        }
        
        guard !Task.isCancelled else { return nil }
        let result = await loadingTask.result
        return try result.get()
    }
    
    func getDescription(_ itemId: String) async throws  -> Models.DescriptionModel? {
        let loadingTask = Task { () -> Models.DescriptionModel? in
            guard let url = URL(string: Endpoint.description(itemId).url), !Task.isCancelled else { return nil }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(Models.DescriptionModel.self, from: data)
            return decodedData
        }
        
        guard !Task.isCancelled else { return nil }
        let result = await loadingTask.result
        return try result.get()
    }
    
    func getImageUrl(_ imageId: String?) -> URL? {
        guard let imageId else { return nil }
        let endpoint = Endpoint.images(imageId).url
        return URL(string: endpoint)
    }
}
