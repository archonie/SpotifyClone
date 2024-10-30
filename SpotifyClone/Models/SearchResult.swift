//
//  SearchResult.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 30.10.2024.
//


enum SearchResult{
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
