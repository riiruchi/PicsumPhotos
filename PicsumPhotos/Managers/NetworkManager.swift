//
//  NetworkManager.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://picsum.photos/v2/list"
    
    private init() {}
    
    func fetchPhotos(page: Int, limit: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?page=\(page)&limit=\(limit)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
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

