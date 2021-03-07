//
//  ViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/1/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    struct Constants {
        static let cornerRaius = CGFloat(10.0)
    }
    
    // Create aumonyous closures
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "polligraph"
        label.font = label.font.withSize(62)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .center
        label.sizeToFit()
        label.backgroundColor = .red
        return label
    }()

    private let subTitle: UILabel = {
        let label = UILabel()
        label.text = "Pick your side."
        label.font = label.font.withSize(24)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .right
        label.backgroundColor = .blue
        
        return label
    }()
        
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create an Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = Constants.cornerRaius
        return button
    }()
    
    private let signinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.black , for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = Constants.cornerRaius
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        createAccountButton.addTarget(
            self,
            action: #selector(didTapCreatAccount),
            for: .touchUpInside)
        
        signinButton.addTarget(
            self,
            action: #selector(didTapSignIn),
            for: .touchUpInside)
        
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainTitle.frame = CGRect(
            x: 70,
            y: view.safeAreaInsets.top + 80,
            width: view.width - 140,
            height: 80)
        
        subTitle.frame = CGRect(
            x: 70,
            y: mainTitle.bottom + 10,
            width: view.width - 140,
            height: 35)

        createAccountButton.frame = CGRect(
            x: 50,
            y: view.height - view.safeAreaInsets.bottom - 350,
            width: view.width - 100,
            height: 46)

        signinButton.frame = CGRect(
            x: 50,
            y: createAccountButton.bottom + 20,
            width: view.width - 100,
            height: 46)
        
    }
    
    private func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(subTitle)
        view.addSubview(createAccountButton)
        view.addSubview(signinButton)
    }
    
    private func createBackButton() -> UIButton {
        let backButtonImage = UIImage(systemName: "arrow.backward")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return backButton
    }
    
    @objc private func didTapCreatAccount() {
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

