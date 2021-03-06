//
//  TabBarViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/6/21.
//

import UIKit

class TabBarViewController: UITabBarController {

//    private var tabBarDelegate = TabBarDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()

    }
    
    private func createTabBar() {
        
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let newPostVC = NewPostViewController()
        let notificationVC = NotificationViewController()
        let profileVC = ProfileViewController()
        
        let viewControllerData: [(UIViewController, UIImage, UIImage)] = [
            (homeVC, UIImage(systemName: "house")!, UIImage(systemName: "house.fill")!),
            (searchVC, UIImage(systemName: "magnifyingglass.circle")!, UIImage(systemName: "magnifyingglass.circle.fill")!),
            (newPostVC, UIImage(systemName: "plus.circle")!, UIImage(systemName: "plus.circle.fill")!),
            (notificationVC, UIImage(systemName: "bell")!, UIImage(systemName: "bell.fill")!),
            (profileVC, UIImage(systemName: "person.crop.circle")!, UIImage(systemName: "person.crop.circle.fill")!),
        ]
        
        let viewControllers = viewControllerData.map { (viewController, defaultImage, selectedImage ) -> UINavigationController in
            
            let navigation = UINavigationController(rootViewController: viewController)
            navigation.tabBarItem.image = defaultImage
            navigation.tabBarItem.selectedImage = selectedImage
            
            return navigation
        }
//        setViewControllers(viewControllers, animated: false)
        
        self.viewControllers = viewControllers
        self.tabBar.isTranslucent = false
        self.delegate = TabBarDelegate()

        // we always want to make sure the icon image to be original
        // not blue default color that swift provides
        if let items = self.tabBar.items {
            for item in items {
                if let image = item.image {
                    item.image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                }

                if let selectedImage = item.selectedImage {
                    item.selectedImage = selectedImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                }
                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            }
        }
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = UIColor.white
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            guard let window = sceneDelegate.window else { return }
            window.rootViewController = self
        }
//        let sceneDelegate = viewControllers.window.windowScence.delegate
//            UIApplication.shared.delegate as! Polligraph.SceneDelegate
//        setViewControllers(viewControllers, animated: false)
    }

}
