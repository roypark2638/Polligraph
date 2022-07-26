//
//  ViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/1/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - Properties

    // For user auth, this variable takes nothing and returns nothing
    public var completion: (() -> Void)?
        
    struct Constants {
        static let cornerRadius = CGFloat(20.0)
    }
    
    // Create anonymous closures
    private let imageContainerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let titleView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Polligraph Main"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let createAccountButton = AuthButton(type: .black, title: "Create an Account")
    private let signInButton = AuthButton(type: .secondary, title: "Sign In")
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupButtonActions()
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpLayout()
    }
    
    // MARK: - Methods
    
    private func addSubviews() {
        view.addSubview(imageContainerView)
        view.addSubview(createAccountButton)
        view.addSubview(signInButton)
    }
    
    private func setupButtonActions() {
        createAccountButton.addTarget(
            self,
            action: #selector(didTapCreateAccount),
            for: .touchUpInside)
        
        signInButton.addTarget(
            self,
            action: #selector(didTapSignIn),
            for: .touchUpInside)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            imageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            imageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        imageContainerView.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            titleView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
            titleView.widthAnchor.constraint(equalTo: imageContainerView.widthAnchor, multiplier: 0.7)
        ])

        createAccountButton.frame = CGRect(
            x: 24,
            y: (view.height/1.5),
            width: view.width - 48,
            height: 50)

        signInButton.frame = CGRect(
            x: 24,
            y: createAccountButton.bottom + 16,
            width: view.width - 48,
            height: 50)
        
    }
    
    private func createBackButton() -> UIButton {
        let backButtonImage = UIImage(named: "Back Arrow")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return backButton
    }
    
    // MARK: - Objc Methods
    
    @objc private func didTapCreateAccount() {
        let vc = RegistrationViewController()        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.prefersLargeTitles = true
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: createBackButton())
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func didTapSignIn() {
        let vc = SignInViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.prefersLargeTitles = true
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: createBackButton())
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func backAction() {
        dismiss(animated: true, completion: nil)
    }

}
