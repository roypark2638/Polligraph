//
//  ProfileHeaderCollectionReusableView.swift
//  Polligraph
//
//  Created by Roy Park on 3/26/21.
//

import UIKit
import SDWebImage

protocol ProfileHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapPollsButtonWith viewModel: ProfileHeaderViewModel)
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapEditProfileButtonWith viewModel: ProfileHeaderViewModel)
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapFollowButtonWith viewModel: ProfileHeaderViewModel)
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapUnfollowButtonWith viewModel: ProfileHeaderViewModel)
    
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
        
    // MARK: - Properties
    
    weak var delegate: ProfileHeaderCollectionReusableViewDelegate?
    
    var viewModel: ProfileHeaderViewModel?
    
    static let identifier = "ProfileHeaderCollectionReusableView"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Profile Image")
        return imageView
    }()
    
    private let pollsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-regular", size: 14)
        let attributedString = NSMutableAttributedString(string: "Polls")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 0.7, range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.textColor = .lightGray
        return label
    }()
    
    private let pollsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Poll UI"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.titleLabel?.numberOfLines = 1
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        return button
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-regular", size: 14)
        let attributedString = NSMutableAttributedString(string: "Followers")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 0.7, range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.textColor = .lightGray
        return label
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Followers Icon"), for: .normal)        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.titleLabel?.numberOfLines = 1
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        return button
    }()
    
    private let primaryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.numberOfLines = 1
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .label
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 18.0
        return button
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        let attributedString = NSMutableAttributedString(string: "Polinews")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 0.7, range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.textColor = .label
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto-regular", size: 16)
        let attributedString = NSMutableAttributedString(string: "Please follow if you want to up to date news on politics!")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 0.5, range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private var isFollowing = false
    
    private var actionType = ProfileButtonType.edit

    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemBackground
        addSubviews()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpLayout()
    }
    
    // MARK: - Methods
    
    private func configureButtons() {
        pollsButton.addTarget(self, action: #selector(didTapPollButton), for: .touchUpInside)
//        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        primaryButton.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
    }
    
    private func addSubviews() {
        addSubview(profileImageView)
        addSubview(pollsLabel)
        addSubview(followersLabel)
        addSubview(primaryButton)
        addSubview(pollsButton)
        addSubview(followersButton)
        addSubview(fullNameLabel)
        addSubview(bioLabel)
    }
    
    private func setUpLayout() {
        let profileSize: CGFloat = 90
        profileImageView.frame = CGRect(
            x: 16,
            y: safeAreaInsets.top + 8,
            width: profileSize,
            height: profileSize
        ).integral
        profileImageView.layer.cornerRadius = profileSize/2
        
                                
        followersLabel.sizeToFit()
        followersLabel.frame = CGRect(
            x: width - followersLabel.width - 17,
            y: profileImageView.top,
            width: followersLabel.width,
            height: followersLabel.height
        )
        
        pollsLabel.sizeToFit()
        pollsLabel.frame = CGRect(
            x: followersLabel.left - 40 - pollsLabel.width,
            y: profileImageView.top,
            width: pollsLabel.width,
            height: pollsLabel.height
        )
        
        followersButton.sizeToFit()
        followersButton.frame = CGRect(
            x: followersLabel.center.x - (followersButton.width + 24)/2,
            y: followersLabel.bottom + 8,
            width: followersButton.width + 24,
            height: 20
        )
        
        pollsButton.sizeToFit()
        pollsButton.frame = CGRect(
            x: pollsLabel.center.x - (pollsButton.width + 24)/2,
            y: pollsLabel.bottom + 8,
            width: pollsButton.width + 24,
            height: 20
        )
        
        primaryButton.sizeToFit()
        primaryButton.frame = CGRect(
            x: width - 16 - primaryButton.width - 24,
            y: pollsButton.bottom + 16,
            width: primaryButton.width + 32,
            height: 36
        ).integral
        
        fullNameLabel.sizeToFit()
        fullNameLabel.frame = CGRect(
            x: 16,
            y: profileImageView.bottom + 24,
            width: fullNameLabel.width,
            height: 19
        )
        
        bioLabel.sizeToFit()
        let bioLabelSize = bioLabel.sizeThatFits(CGSize(width: width - 32, height: height))
        bioLabel.frame = CGRect(
            x: 16,
            y: fullNameLabel.bottom + 8,
            width: bioLabelSize.width,
            height: bioLabelSize.height
        )
        
    }
    
    func configure(with viewModel: ProfileHeaderViewModel) {
        self.viewModel = viewModel
        
        let followersAttributedString = NSMutableAttributedString(string: "\(viewModel.followerCount.followersFormatted)")
        followersAttributedString.addAttribute(NSAttributedString.Key.kern, value: 1.1, range: NSMakeRange(0, followersAttributedString.length))

        followersButton.setAttributedTitle(followersAttributedString, for: .normal)
        
        let pollsAttributedString = NSMutableAttributedString(string: "\(viewModel.pollsCount.followersFormatted)")
        pollsAttributedString.addAttribute(NSAttributedString.Key.kern, value: 1.1, range: NSMakeRange(0, pollsAttributedString.length))
        pollsButton.setAttributedTitle(pollsAttributedString, for: .normal)
        
        bioLabel.text = viewModel.bio
        
        if let imageURL = viewModel.profileImageURL {
            profileImageView.sd_setImage(with: imageURL, completed: nil)
        }
        else {
            profileImageView.image = UIImage(named: "Profile Image")
        }
        self.actionType = viewModel.buttonType
        
        switch actionType {
        case .edit:
            primaryButton.backgroundColor = .label
            primaryButton.setTitle("Edit Profile", for: .normal)
        case .follow(isFollowing: let isFollowing):
            self.isFollowing = isFollowing
            updateFollowButton()
        }

    }
    
    private func updateFollowButton() {
        primaryButton.backgroundColor = isFollowing ? .systemGray5 : .label
        primaryButton.setTitleColor(isFollowing ? .label : .systemBackground, for: .normal)
        primaryButton.setTitle(isFollowing ? "Following" : "Follow", for: .normal)
    }
    
    // MARK: - Objc Methods
    
    @objc private func didTapPollButton() {
        guard let safeViewModel = viewModel else { return }
        delegate?.profileHeaderCollectionReusableView(self, didTapPollsButtonWith: safeViewModel)
    }
//
//    @objc private func didTapFollowersButton() {
//        delegate?.profileHeaderCollectionReusableView(self, didTapFollowersButtonWith: "")
//    }
    
    @objc private func didTapPrimaryButton() {
        guard let safeViewModel = viewModel else { return }
        switch actionType {
        case .edit:
            delegate?.profileHeaderCollectionReusableView(
                self,
                didTapEditProfileButtonWith: safeViewModel
            )

        case .follow(isFollowing: let isFollowing):
            if self.isFollowing {
                // unfollow
                delegate?.profileHeaderCollectionReusableView(
                    self,
                    didTapUnfollowButtonWith: safeViewModel
                )
            }
            else {
                // follow
                delegate?.profileHeaderCollectionReusableView(
                    self,
                    didTapFollowButtonWith: safeViewModel
                )
            }
            
            self.isFollowing = !isFollowing
            updateFollowButton()
        }
    }
}
