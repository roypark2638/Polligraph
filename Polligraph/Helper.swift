//
//  Helper.swift
//  Polligraph
//
//  Created by Roy Park on 3/2/21.
//

import Foundation
import UIKit

struct Helper {
    
    static func errorAlert(title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        return alert
    }
    
    let tabBarDelegate = TabBarDelegate()
    
    static func login() {
        
        let tabController = UITabBarController()

        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let newPostStoryboard = UIStoryboard(name: "NewPost", bundle: nil)
        let notificationStoryboard = UIStoryboard(name: "Notification", bundle: nil)
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        
        let homeViewController = homeStoryboard.instantiateViewController(identifier: "Home") as! HomeViewController
        let searchViewController = searchStoryboard.instantiateViewController(identifier: "Search") as! SearchViewController
        let newPostViewController = newPostStoryboard.instantiateViewController(identifier: "NewPost") as! NewPostViewController
        let notificationViewController = notificationStoryboard.instantiateViewController(identifier: "Notification") as! NotificationViewController
        let profileViewController = profileStoryboard.instantiateViewController(identifier: "Profile") as! ProfileViewController
        
        let viewControllerData: [(UIViewController, UIImage, UIImage)] = [
            (homeViewController, UIImage(systemName: "house")!, UIImage(systemName: "house.fill")!),
            (searchViewController, UIImage(systemName: "magnifyingglass.circle")!, UIImage(systemName: "magnifyingglass.circle.fill")!),
            (newPostViewController, UIImage(systemName: "plus.circle")!, UIImage(systemName: "plus.circle.fill")!),
            (notificationViewController, UIImage(systemName: "bell")!, UIImage(systemName: "bell.fill")!),
            (profileViewController, UIImage(systemName: "person.crop.circle")!, UIImage(systemName: "person.crop.circle.fill")!),
        ]
        
        let viewControllers = viewControllerData.map { (viewController, defaultImage, selectedImage ) -> UINavigationController in
            
            let navigation = UINavigationController(rootViewController: viewController)
            navigation.tabBarItem.image = defaultImage
            navigation.tabBarItem.selectedImage = selectedImage
            
            return navigation
        }
        
        tabController.viewControllers = viewControllers
        tabController.tabBar.isTranslucent = false
        tabController.delegate = TabBarDelegate()
        
        // we always want to make sure the icon image to be original
        // not blue default color that swift provides
        if let items = tabController.tabBar.items {
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
            window.rootViewController = tabController
        }
//        let sceneDelegate = viewControllers.window.windowScence.delegate
//            UIApplication.shared.delegate as! Polligraph.SceneDelegate
        
    }
}
