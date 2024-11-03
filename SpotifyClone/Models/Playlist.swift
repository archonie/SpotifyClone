//
//  Playlist.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 16.10.2024.
//

import Foundation
struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]?
    let name: String
    let owner: User
}

   
