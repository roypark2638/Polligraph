//
//  ProfileViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/3/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var headerViewModel: ProfileHeaderViewModel?
    
    private var isCurrentUser: Bool {
        return user.username.lowercased() == UserDefaults.standard.string(forKey: "username")?.lowercased() ?? ""
    }
    
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
        
    private var posts: [Post] = []
        
    
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
        title = user.username
        
        view.addSubview(collectionView)
        configureNavigationBar()
        configureCollectionView()
        fetchProfileInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Methods
    
    private func fetchProfileInfo() {
        let username = user.username
        let group = DispatchGroup()
        
        // Fetch Posts
        group.enter()
        DatabaseManager.shared.getPosts(for: username) { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
            
            case .success(let posts):
                print("success\n\n")
                self?.posts = posts
                break
            case .failure(let error):
                
                print("Failed with getting Posts with an error: \(error) \n\n")
                break
            }
        }
        
        // Fetch Profile Header Info

        var profilePictureURL: URL?
        var followerCount = 0
        var pollsCount = 0
        var buttonType: ProfileButtonType = .edit
        var bio: String?
        var displayName: String?
        
        // To-do later
        // Counts (Post, followers)
        // create getUserCounts in DatabaseManager
        
        // Bio, name
        DatabaseManager.shared.getUserInfo(username: user.username) { userInfo in
            displayName = userInfo?.displayName
            bio = userInfo?.bio
        }
        
        // Profile picture url
        group.enter()
        StorageManager.shared.getProfilePictureURL(for: user.username) { url in
            if url == nil {
                print("There is no profile picture for this user")
            }
            defer {
                group.leave()
            }
            profilePictureURL = url
        }
        
        // if profile is not for current user, get follow state
        if !isCurrentUser {
            // get follow state
            group.enter()
            DatabaseManager.shared.isFollowing(
                targetUsername: user.username) { isFollowing in
                defer {
                    group.leave()
                }
                buttonType = .follow(isFollowing: isFollowing)
            }
        }
        
        group.notify(queue: .main) {
            self.headerViewModel = ProfileHeaderViewModel(
                profileImageURL: profilePictureURL,
                followerCount: 100,
                pollsCount: 1000,
                buttonType: buttonType,
                bio: bio,
                displayName: displayName
            )
            self.collectionView.reloadData()
        }
        
    }
    
    private func configureCollectionView() {
        // layout allows us the name implies to control things about how the collection view is laid out
        // somethings like scroll direction and item size
    }
    
    private func configureNavigationBar() {
//        let username = UserDefaults.standard.string(forKey: "username")?.uppercased() ?? "ME"
//        if title == username {
//
//        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Settings Icon"),
            style: .done,
            target: self,
            action: #selector(didTapSettingsButton))
//        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    // MARK: - Objc Methods
 
    @objc private func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.navigationBar.tintColor = .label
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

//        let viewModel = ProfileHeaderViewModel(profileImageURL: nil , followerCount: 110_000, pollsCount: 92_000)
        if let viewModel = headerViewModel {
            profileHeader.configure(with: viewModel)
        }
//        profileHeader.configure(with: headerViewModel)
        
        
        return profileHeader
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        var height: CGFloat = 157
        // convert string into NSString
        guard let headerViewModel = headerViewModel else { return CGSize(width: collectionView.width, height: collectionView.width) }
        
        if let bioString = headerViewModel.bio as? NSString,
           let font = UIFont(name: "Roboto-regular", size: 16)
            {
            let bioRect = bioString.boundingRect(
                with: CGSize(width: view.width, height: 1000),
                options: .usesLineFragmentOrigin,
                attributes: [
                    .font : font,
                    .kern : NSNumber(value: 0.5)
                ],
                context: nil
            )
            height += bioRect.height
        }
        
        if section == 0 {
            
            return CGSize(width: collectionView.width,
                          height: height)
        }
        return CGSize(width: collectionView.width, height: 51)
    }
    
}

// MARK: - ProfileHeaderCollectionReusableViewDelegate

extension ProfileViewController: ProfileHeaderCollectionReusableViewDelegate {
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapPollsButtonWith viewModel: ProfileHeaderViewModel) {
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapEditProfileButtonWith viewModel: ProfileHeaderViewModel) {
        let vc = EditProfileViewController()
        vc.completion = { [weak self] in
            // refetch header info
            self?.headerViewModel = nil
            self?.fetchProfileInfo()
        }
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true, completion: nil)
    }
    
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapFollowButtonWith viewModel: ProfileHeaderViewModel) {
        
    }
    
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapUnfollowButtonWith viewModel: ProfileHeaderViewModel) {
        
    }
    
    
}
