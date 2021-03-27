//
//  ProfileViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/3/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false        
        
        
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.register(ProfileHeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier)
        collectionView.register(ProfileTabsCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        return collectionView
    }()
    
    private var user: User
        
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var userPost = [UserPost]()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        title = "polinews"        
        
        view.addSubview(collectionView)
        configureNavigationBar()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Methods
    
    private func configureCollectionView() {
        // layout allows us the name implies to control things about how the collection view is laid out
        // somethings like scroll direction and item size
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Settings Icon"),
            style: .done,
            target: self,
            action: #selector(didTapSettingsButton))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    // MARK: - Objc Methods
 
    @objc private func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return 30
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath)
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.width - 24) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            // tabs header
            let tabControlHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
                for: indexPath
            ) as! ProfileTabsCollectionReusableView
            return tabControlHeader
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier,
            for: indexPath
        ) as! ProfileHeaderCollectionReusableView
        
        profileHeader.delegate = self
        let viewModel = ProfileHeaderViewModel(profileImageURL: nil, isFollowing: true, followerCount: 110_000, pollsCount: 92_000)
        profileHeader.configure(with: viewModel)
        
        
        return profileHeader
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width,
                          height: collectionView.height/4 + 20)
        }
        return CGSize(width: collectionView.width, height: 51)
    }
    
}

extension ProfileViewController: ProfileHeaderCollectionReusableViewDelegate {
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapPollsButtonWith viewModel: ProfileHeaderViewModel) {
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderCollectionReusableView(
        _ header: ProfileHeaderCollectionReusableView,
        didTapPrimaryButtonWith viewModel: ProfileHeaderViewModel
    ) {
        let vc = SettingsViewController()
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    
}
