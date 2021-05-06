//
//  TabBarDelegate.swift
//  Polligraph
//
//  Created by Roy Park on 3/4/21.
//

import UIKit

// from the onboarding storyboard, when the user click the bar button, this will notify to the controller
class TabBarDelegate: NSObject, UITabBarControllerDelegate{
    
    // when the user did select the icon
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let navigationController = viewController as? UINavigationController
        
        _ = navigationController?.popViewController(animated: false)
        
    }
    
    // tell us whether the new contorller that we are currently trying to tap on should be selcted or not
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let selectedViewController = tabBarController.selectedViewController
        
        guard let _selectedViewControlelr = selectedViewController else { return false }
        
        // if user is on the same page, return false. nothing happens
        if viewController == _selectedViewControlelr { return false }
        
        // get the controller index that we are trying to go to
        // in the event that we can't find it, then we will allow the new view conotrller that we're tying to go to be selected anyway as normal
        guard let controllerIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else { return true }
        
        if controllerIndex == 2 {
            let newPostStoryboard = UIStoryboard(name: "NewPost", bundle: nil)
            let newPostViewController = newPostStoryboard.instantiateViewController(identifier: "NewPost") as! CameraViewController
            
            let navController = UINavigationController(rootViewController: newPostViewController)
            
            _selectedViewControlelr.present(navController, animated: true, completion: nil)
            
            // returning false is preventing the default behavior of the tab when we select that middle tab which is the newpost.
            // instead we present viewcontroller modelly
            return false
        }
        
        // when the selected view controller is not 2, then we just want normal behavior
        
        let navigationController = viewController as? UINavigationController
        _ = navigationController?.popToRootViewController(animated: false)
        
        return true
        
    }
}
