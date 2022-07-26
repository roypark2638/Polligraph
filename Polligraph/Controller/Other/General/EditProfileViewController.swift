//
//  EditProfileViewController.swift
//  Polligraph
//
//  Created by Roy Park on 4/6/21.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    // MARK:- Properties
    
    public var completion: (() -> Void)?
    
    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Profile Image")
        return view
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Add Icon"), for: .normal)
        button.clipsToBounds = true
        return button
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = .lightGray
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        return label
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Display Name"
        label.textColor = .lightGray
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Bio"
        label.textColor = .lightGray
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        return label
    }()
    
    private let usernameCountLabel: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.textColor = .secondaryLabel
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        return label
    }()
    
    private let displayNameCountLabel: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.textColor = .secondaryLabel
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        return label
    }()
    
    private let bioCountLabel: UILabel = {
        let label = UILabel()
        label.text = "150"
        label.textColor = .secondaryLabel
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        return label
    }()
    
    private let usernameTextField = TextField(type: .other, title: nil)
    private let displayNameTextField = TextField(type: .other, title: nil)
    private let bioTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 20.0
        textView.layer.masksToBounds = true
        textView.isEditable = true
        textView.font = UIFont(name: "Roboto-Regular", size: 16)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        textView.returnKeyType = .done
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        return textView
    }()
    
    
    // MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        hidesBottomBarWhenPushed = true
        title = "Edit Profile"
        configureNavigationBar()
        configureButtons()
        addSubviews()
        
        usernameTextField.delegate = self
        displayNameTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapChangeImage))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tap)
        
        guard let username = UserDefaults.standard.string(forKey: "username")?.lowercased() else { return }
        DatabaseManager.shared.getUserInfo(username: username) { [weak self] userInfo in
            print(userInfo)
//            DispatchQueue.main.async {
//                if let userInfo = userInfo {
//
//                }
//            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayouts()
    }
    
    // MARK: - Methods
    
    private func configureButtons() {
        plusButton.addTarget(self, action: #selector(didTapChangeImage), for: .touchUpInside)
    }
    
    private func addSubviews() {
        view.addSubview(profileImageView)
        view.addSubview(plusButton)
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(usernameCountLabel)
        view.addSubview(bioLabel)
        view.addSubview(bioTextView)
        view.addSubview(bioCountLabel)
        view.addSubview(displayNameLabel)
        view.addSubview(displayNameTextField)
        view.addSubview(displayNameCountLabel)
    }
    
    private func configureLayouts() {
        let profileImageSize = CGFloat(110)
        
        profileImageView.frame = CGRect(
            x: (view.width - profileImageSize)/2,
            y: view.safeAreaInsets.top + 16,
            width: profileImageSize,
            height: profileImageSize
        )
        let plusButtonSize = CGFloat(27)
        
        plusButton.frame = CGRect(
            x: profileImageView.right - plusButtonSize - 5,
            y: profileImageView.bottom - plusButtonSize,
            width: plusButtonSize,
            height: plusButtonSize
        )
        usernameLabel.sizeToFit()
        usernameLabel.frame = CGRect(
            x: 24,
            y: profileImageView.bottom + 32,
            width: usernameLabel.width,
            height: 20
        )
        
        usernameTextField.frame = CGRect(
            x: 16,
            y: usernameLabel.bottom + 8,
            width: view.width - 32,
            height: 36
        )
        
        usernameCountLabel.sizeToFit()
        usernameCountLabel.frame = CGRect(
            x: view.width - 24 - usernameCountLabel.width,
            y: usernameTextField.bottom + 8,
            width: usernameCountLabel.width,
            height: 20
        )
        
        displayNameLabel.sizeToFit()
        displayNameLabel.frame = CGRect(
            x: 24,
            y: usernameCountLabel.bottom,
            width: displayNameLabel.width,
            height: 20
        )
        
        displayNameTextField.frame = CGRect(
            x: 16,
            y: displayNameLabel.bottom + 8,
            width: view.width - 32,
            height: 36
        )
        
        displayNameCountLabel.sizeToFit()
        displayNameCountLabel.frame = CGRect(
            x: view.width - 24 - displayNameCountLabel.width,
            y: displayNameTextField.bottom + 8,
            width: displayNameCountLabel.width,
            height: 20
        )
        
        bioLabel.sizeToFit()
        bioLabel.frame = CGRect(
            x: 24,
            y: displayNameCountLabel.bottom,
            width: bioLabel.width,
            height: 20
        )
        
        bioTextView.frame = CGRect(
            x: 16,
            y: bioLabel.bottom + 8,
            width: view.width - 32,
            height: 96
        )
        
        bioCountLabel.sizeToFit()
        bioCountLabel.frame = CGRect(
            x: view.width - 24 - bioCountLabel.width,
            y: bioTextView.bottom + 8,
            width: bioCountLabel.width,
            height: 20
        )
        
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .label
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(didTapSave)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Back Arrow"),
            style: .done,
            target: self,
            action: #selector(didTapBackArrow)
        )
        
    }
    
    // MARK: - Objc
    
    @objc private func didTapSave() {
        let username = usernameTextField.text ?? ""
        let bio = bioTextView.text ?? ""
        let displayName = displayNameTextField.text ?? ""
        guard let image = profileImageView.image, // always have an image with default view
              let data = image.pngData()
        else { return }
        
        let newInfo = UserInfo(username: username, displayName: displayName, bio: bio)
        
        DatabaseManager.shared.setUserInfo(userInfo: newInfo) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.completion?() // refresh the profile
                    self?.didTapBackArrow()
                }
            }
        }
    }

    @objc private func didTapBackArrow() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeImage() {
        let vc = SelectPictureViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }

}


extension EditProfileViewController: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        let maxIntCount = 30

        guard let textCount = textField.text?.count else { return  }
        usernameCountLabel.text = String(maxIntCount - textCount)
    }

}
