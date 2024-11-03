//
//  LibraryToggleView.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 2.11.2024.
//

import UIKit


protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylist(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbum(_ toggleView: LibraryToggleView)
}


class LibraryToggleView: UIView {

    enum State {
        case playlist
        case album
    }
    public var state: State = .playlist
    
    weak var delegate: LibraryToggleViewDelegate?
    
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        return button
    }()
    
    private let albumButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistButton)
        addSubview(albumButton)
        addSubview(indicatorView)
        playlistButton.addTarget(self, action: #selector(didTapPlaylist), for: .touchUpInside)
        albumButton.addTarget(self, action: #selector(didTapAlbum), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumButton.frame = CGRect(x: playlistButton.right, y: 0, width: 100, height: 40)
        layoutIndicator()
    }
    
    func layoutIndicator() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(x: 0, y: playlistButton.bottom, width: 100, height: 3)
        case .album:
            indicatorView.frame = CGRect(x: 100, y: albumButton.bottom, width: 100, height: 3)
        }
    }
    
    
    @objc private func didTapPlaylist() {
        state = .playlist
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapPlaylist(self)
    }
    
    @objc private func didTapAlbum() {
        state = .album
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapAlbum(self)
    }
 
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
}
