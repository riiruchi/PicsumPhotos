//
//  NetworkManager.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchPhotos(page: Int, limit: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let urlString = "https://picsum.photos/v2/list?page=\(page)&limit=\(limit)"
        AF.request(urlString).responseDecodable(of: [Photo].self) { response in
            switch response.result {
            case .success(let photos):
                completion(.success(photos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
