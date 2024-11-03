//
//  LibraryPlaylistsViewController.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 2.11.2024.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {

    private var playlists = [Playlist]()
    
    private let noPlaylistView = ActionLabelView()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        
        table.isHidden = true
        return table
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setUpNoPlaylistsView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistView.center = view.center
        tableView.frame = view.bounds
    }
    
    private func setUpNoPlaylistsView() {
        view.addSubview(noPlaylistView)
        noPlaylistView.configure(with: ActionLabelViewModel(text: "You don't have any playlists yet.", actionTitle: "Create"))
        noPlaylistView.delegate = self
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            //Show label
            noPlaylistView.isHidden = false
            tableView.isHidden = true
        }
        else {
            // Show table
            tableView.reloadData()
            tableView.isHidden = false
            noPlaylistView.isHidden = true
        }
    }
    
    private func fetchData(){
        APICaller.shared.getCurrentUserPlaylists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    print(playlists)
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    public func showCreatePlaylistAlert() {
        let alert = UIAlertController(title: "New Playlist", message: "Enter playlist name.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Playlist..."
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }
            
            APICaller.shared.createPlaylist(with: text) { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        // Refresh list of playlists
                        self?.fetchData()
                        self?.tableView.reloadData()
                    }
                } else {
                    print("Failed to create playlist")
                }
                
            }
        }))
        
        present(alert, animated: true)
    }
    
}


extension LibraryPlaylistsViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        showCreatePlaylistAlert()
    }
}

extension LibraryPlaylistsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let playlist = playlists[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(title: playlist.name, subtitle: playlist.owner.display_name, imageURL: URL(string: playlist.images?.first?.url ?? "")))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
 
