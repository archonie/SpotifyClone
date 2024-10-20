//
//  Settings.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 17.10.2024.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}


struct Option {
    let title: String
    let handler: () -> Void
}
