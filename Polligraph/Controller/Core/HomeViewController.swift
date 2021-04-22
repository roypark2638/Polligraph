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
        
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func configureNavigationBar() {
        let titleViewImage = UIImageView(image: UIImage(named: "Polligraph Logo"))
        navigationItem.titleView = titleViewImage

        let menuViewImage = UIImage(named: "Hamburger Icon")
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: menuViewImage,
            style: .plain,
            target: self,
            action: #selector(didTapMenu)
        )
    }
    
    @objc private func didTapMenu() {
        
    }

}
