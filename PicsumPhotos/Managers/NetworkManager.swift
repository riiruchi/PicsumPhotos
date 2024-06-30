//
//  NetworkManager.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import Foundation

/// Singleton class responsible for network requests.
class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://picsum.photos/v2/list"
    
    private init() {}
    
    /// Fetches photos from the API with pagination.
    ///
    /// - Parameters:
    ///   - page: The page number to fetch.
    ///   - limit: The number of items per page.
    ///   - completion: Completion handler with Result containing either an array of `Photo` or an `Error`.
    func fetchPhotos(page: Int, limit: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?page=\(page)&limit=\(limit)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // If an error occurs, call the completion handler with the error.
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(.success(photos))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}

