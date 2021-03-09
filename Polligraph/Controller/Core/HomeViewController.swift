//
//  HomeViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/3/21.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("failed to sign out")
        }
        // check auth status
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            // show onboarding in page
            let onboardingVC = OnboardingViewController()
            // set the onboardingVC fullScreen so that user can't swipe the page away
            onboardingVC.modalPresentationStyle = .fullScreen
            
            present(onboardingVC, animated: false)
        }
        else {
            
        }
    }
    
    
    


}
