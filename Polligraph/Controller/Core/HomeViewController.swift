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

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        // check auth status
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            // show singin page
            let signinVC = SignInViewController()
            // set the signinVC fullscreen so that user can't swipe the page away
            signinVC.modalPresentationStyle = .fullScreen
            
            present(signinVC, animated: true, completion: nil)
        }
        else {
            
        }
    }
    


}
