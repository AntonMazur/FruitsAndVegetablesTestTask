//
//  ImageLoader.swift
//  iOS-Test
//
//  Created by Anton Mazur on 05.01.2024.
//

import UIKit

final class ImageLoader {
    private var loadedImages: [URL: UIImage] = [:]
    private var requestsInProgress: [UUID: URLSessionDataTask] = [:]
    
    func loadImage(url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            defer { self.requestsInProgress.removeValue(forKey: uuid) }
            
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }
            
            guard let error = error else { return }
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        
        task.resume()
        requestsInProgress[uuid] = task
        
        return uuid
    }
    
    func cancelLoading(with uuid: UUID) {
        requestsInProgress[uuid]?.cancel()
        requestsInProgress.removeValue(forKey: uuid)
    }
}
