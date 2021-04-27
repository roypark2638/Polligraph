//
//  TabBarViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/6/21.
//

import UIKit
import FirebaseAuth

class TabBarViewController: UITabBarController {
    
    private var onboardingPresented = false

//    private var tabBarDelegate = TabBarDelegate()
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate = self
        
        // Check user auth status
        if !onboardingPresented {
            presentOnboardingIfNeeded()
        }
    }
    
    // MARK: Methods
    
    private func presentOnboardingIfNeeded() {
        if !AuthManager.shared.isSignedIn() {
            onboardingPresented = true
            let vc = OnboardingViewController()
            vc.completion = { [weak self] in
                self?.onboardingPresented = false
            }
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false, completion: nil)
        }
        else {
            
        }
    }
    
    private func createTabBar() {
        
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let newPostVC = NewPostViewController()
        let notificationVC = NotificationViewController()
        
        
        let profileVC = ProfileViewController(
            user: User(
                username: UserDefaults.standard.string(forKey: "username") ?? "me",
                bio: "Please follow if you want up to date news on politics!",
                name: (first: "roy", last: "park"),
//                birthDate: nil,
                gender: .female,
                counts: UserCount(followers: 105, following: 105, posts: 105)
            )
        )
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let newPostNav = UINavigationController(rootViewController: newPostVC)
        let notificationNav = UINavigationController(rootViewController: notificationVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        homeNav.navigationBar.backgroundColor = .systemBackground
        homeNav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        homeNav.navigationBar.shadowImage = UIImage()
        homeNav.navigationBar.isTranslucent = false

        searchNav.navigationBar.backgroundColor = .clear
        searchNav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        searchNav.navigationBar.shadowImage = UIImage()
        
        
        notificationNav.navigationBar.backgroundColor = .clear
        notificationNav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        notificationNav.navigationBar.shadowImage = UIImage()
        
        profileNav.navigationBar.isTranslucent = false
        profileNav.navigationBar.backgroundColor = .systemBackground
        profileNav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        profileNav.navigationBar.shadowImage = UIImage()
        profileNav.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18)
        ]

        homeNav.navigationBar.tintColor = .label
        searchNav.navigationBar.tintColor = .label
        notificationNav.navigationBar.tintColor = .label
        profileNav.navigationBar.tintColor = .label
        
        tabBar.unselectedItemTintColor = .black
        UITabBar.appearance().tintColor = .label
//        let appearance = tabBar.standardAppearance
//        appearance.shadowImage = nil
//        appearance.shadowColor = nil
//        tabBar.standardAppearance = appearance
        
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.isTranslucent = false
        
        
        setViewControllers(viewControllers, animated: false)
        
        homeNav.tabBarItem = UITabBarItem(title: nil,
                                          image: UIImage(systemName: "house"),
                                          selectedImage: UIImage(systemName: "house.fill"))
        searchNav.tabBarItem = UITabBarItem(title: nil,
                                           image: UIImage(systemName: "magnifyingglass.circle"),
                                           selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        newPostNav.tabBarItem = UITabBarItem(title: nil,
                                            image: UIImage(systemName: "plus.circle"),
                                            selectedImage: UIImage(systemName: "plus.circle.fill"))
        notificationNav.tabBarItem = UITabBarItem(title: nil,
                                                 image: UIImage(systemName: "bell"),
                                                 selectedImage: UIImage(systemName: "bell.fill"))
        profileNav.tabBarItem = UITabBarItem(title: nil,
                                            image: UIImage(systemName: "person.crop.circle"),
                                            selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        setViewControllers([homeNav, searchNav, newPostNav, notificationNav, profileNav], animated: false)
    }

}


extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let selectedViewController = tabBarController.selectedViewController
        
        guard let _selectedViewController = selectedViewController else {
            return false
        }
        
        if viewController == _selectedViewController {
            return false
        }
        
        guard let controllerIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        
        if controllerIndex == 2 {
            let newPostVC = NewPostViewController()

            let newPostNav = UINavigationController(rootViewController: newPostVC)
            _selectedViewController.present(newPostNav, animated: true, completion: nil)
            return false
        }
        return true
    }
}
