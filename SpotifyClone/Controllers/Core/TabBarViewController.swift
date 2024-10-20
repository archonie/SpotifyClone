//
//  TabBarViewController.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 16.10.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let libraryVC = LibraryViewController()
        
        homeVC.title = "Browse"
        searchVC.title = "Search"
        libraryVC.title = "Library"
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        searchVC.navigationItem.largeTitleDisplayMode = .always
        libraryVC.navigationItem.largeTitleDisplayMode = .always
        
        let homeNavController = UINavigationController(rootViewController: homeVC)
        let searchNavController = UINavigationController(rootViewController: searchVC)
        let libraryNavController = UINavigationController(rootViewController: libraryVC)
        
        homeNavController.navigationBar.tintColor = .label
        searchNavController.navigationBar.tintColor = .label
        libraryNavController.navigationBar.tintColor = .label
        
        homeNavController.tabBarItem = UITabBarItem(title:"Browse", image: UIImage(systemName: "house"),  tag: 1)
        searchNavController.tabBarItem = UITabBarItem(title:"Search", image: UIImage(systemName: "magnifyingglass"),  tag: 1)
        libraryNavController.tabBarItem = UITabBarItem(title:"Library", image: UIImage(systemName: "music.note.list"),  tag: 1)
        
        homeNavController.navigationBar.prefersLargeTitles = true
        searchNavController.navigationBar.prefersLargeTitles = true
        libraryNavController.navigationBar.prefersLargeTitles = true
        
        setViewControllers([homeNavController, searchNavController, libraryNavController], animated: false)
     }
    



}
