//
//  PlaybackPresenter.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 1.11.2024.
//

import Foundation
import UIKit

final class PlaybackPresenter {
    
    static func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    ) {
        let vc = PlayerViewController()
        vc.title = track.name
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    static func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    ) {
        
        let vc = PlayerViewController()
        vc.title = tracks.first?.name ?? ""
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}
