//
//  FeaturedPlaylists.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 20.10.2024.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let message: String
    let playlists: PlaylistResponse
    
}

struct PlaylistResponse: Codable{
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}



