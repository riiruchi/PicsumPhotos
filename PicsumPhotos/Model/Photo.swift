//
//  ImageItem.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import Foundation

/// Model representing a photo object from the API.
struct Photo: Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
