//
//  ProfileViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/3/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView?
    
    private var userPost = [UserPost]()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    // MARK: - Methods
    
    private func configureCollectionView() {
        // layout allows us the name implies to control things about how the collection view is laid out
        // somethings like scroll direction and item size
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTapSettingsButton))
    }
    
    // MARK: - Objc Methods
 
    @objc private func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }

}
