//
//  CategoriesResponse.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 30.10.2024.
//

struct AllCategoriesResponse: Codable {
    let categories: CategoriesResponse
}

struct CategoriesResponse: Codable {
    let items: [Category]
}


struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}

