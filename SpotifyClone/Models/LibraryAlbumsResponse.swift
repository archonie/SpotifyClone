//
//  LibraryAlbumsResponse.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 7.11.2024.
//

import Foundation

struct LibraryAlbumsResponse : Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
