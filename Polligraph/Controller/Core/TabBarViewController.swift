//
//  TabBarViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/5/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TabBarVC"
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = .black
        
        let homeViewController = HomeViewController()
        let searchViewController = SearchViewController()
        let newPostViewController = NewPostViewController()
        let notificationViewController = NotificationViewController()
        let profileViewController = ProfileViewController()
        
        homeViewController.title = "Home"
        searchViewController.title = "Search"
        newPostViewController.title = "NewPost"
        notificationViewController.title = "Notification"
        profileViewController.title = "Profile"
        
        homeViewController.navigationItem.largeTitleDisplayMode = .always
        searchViewController.navigationItem.largeTitleDisplayMode = .always
        newPostViewController.navigationItem.largeTitleDisplayMode = .always
        notificationViewController.navigationItem.largeTitleDisplayMode = .always
        profileViewController.navigationItem.largeTitleDisplayMode = .always
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        newPostViewController.tabBarItem = UITabBarItem(title: "NewPost", image: UIImage(systemName: "plus.circle"), selectedImage: UIImage(systemName: "plus.circle.fill"))
        notificationViewController.tabBarItem = UITabBarItem(title: "Notification", image: UIImage(systemName: "bell"), selectedImage: UIImage(systemName: "bell.fill"))
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        setViewControllers([homeViewController, searchViewController, newPostViewController, notificationViewController, profileViewController], animated: false)
    }
    
    

}
