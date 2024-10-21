//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 16.10.2024.
//

import UIKit

enum BrowseSectionType {
    case newReleases
    case featuredPlaylists
    case recommendedTracks
}

class HomeViewController: UIViewController {

    private var collectionView: UICollectionView  = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ -> NSCollectionLayoutSection in
            return HomeViewController.createSectionLayout(section: sectionIndex)
        })
    )
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTapSettings)
        )
        configureCollectionView()
        view.addSubview(spinner)
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    }
    
    
    
    private func fetchData() {
        
        //Featured Playlists, Recommended Tracks, New Releases
        
//        APICaller.shared.getNewReleases {result in
//            
//            switch result {
//            case.success(let model):
//                break
//            case .failure(let error):
//                break
//            }
//        }
//        
//        APICaller.shared.getFeaturedPlaylists { result in
//            switch result {
//            case .success(let model):
//                break
//            case .failure(let error):
//                break
//            }
//        }
        APICaller.shared.getRecommendedGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                APICaller.shared.getRecommendations(genres: seeds) { result in
                    switch result {
                    case .success(let success):
                        break
                    case .failure(let failure):
                        break
                    }
                }
            case .failure(let error):
                break
            }
        }
    }

    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0/3)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(390)
                ),
                repeatingSubitem: item,
                count: 3
            )
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        case 1:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1.0/2)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension:  .absolute(150),
                    heightDimension: .absolute(300)
                ),
                repeatingSubitem: item,
                count: 2
            )
            
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.orthogonalScrollingBehavior = .continuous
            return section
        case 2:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(80)
                ),
                repeatingSubitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: verticalGroup)
            return section
        default:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0/3)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(390)
                ),
                repeatingSubitem: item,
                count: 1
            )
            let section = NSCollectionLayoutSection(group: verticalGroup)
            return section
        }
    }

}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            cell.backgroundColor = .systemGreen
        } else if indexPath.section == 1 {
            cell.backgroundColor = .systemBlue
        } else {
            cell.backgroundColor = .systemRed
        }
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
}
