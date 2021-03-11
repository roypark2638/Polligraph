//
//  SignInViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/2/21.
//

import UIKit

class SignInViewController: UIViewController {
    
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
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address or Username"
        field.font = UIFont(name: "Roboto-Bold", size: 16)
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.masksToBounds = true
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.font = UIFont(name: "Roboto-Bold", size: 16)
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.masksToBounds = true
        return field
    }()
    
    private let toggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.secondaryLabel
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        button.backgroundColor = .label
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        button.setTitleColor(.label , for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    private let orSignInWithLabel: UILabel = {
        let label = UILabel()
        label.text = "Or sign in with"
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .center
        label.sizeToFit()
        label.backgroundColor = .systemBackground
        return label
    }()
    
    private let googleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Google"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let appleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Apple"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Facebook"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameEmailField.delegate = self
        passwordField.delegate = self
        view.backgroundColor = .systemBackground
        
        setupButtonActions()
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLayout()
    }
    
    private func addSubviews() {
        view.addSubview(imageContainerView)
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(toggleButton)
        view.addSubview(signInButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(orSignInWithLabel)
        view.addSubview(googleButton)
        view.addSubview(appleButton)
        view.addSubview(facebookButton)
    }
    
    private func setupButtonActions() {
        toggleButton.addTarget(
            self,
            action: #selector(didTapPasswordToggle),
            for: .touchUpInside)
        
        signInButton.addTarget(
            self,
            action: #selector(didTapSignIn),
            for: .touchUpInside)
        
        forgotPasswordButton.addTarget(
            self,
            action: #selector(didTapForgotPassword),
            for: .touchUpInside)
    }
    
    private func setupLayout() {
        
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
        
        usernameEmailField.frame = CGRect(
            x: 35,
            y: (view.height - view.safeAreaInsets.bottom) / 2,
            width: view.width - 70,
            height: 46)
        
        passwordField.frame = CGRect(
            x: 35,
            y: usernameEmailField.bottom + 17,
            width: view.width - 70,
            height: 46)

        signInButton.frame = CGRect(
            x: 35,
            y: passwordField.bottom + 40,
            width: view.width - 70,
            height: 46)

        forgotPasswordButton.frame = CGRect(
            x: 35,
            y: signInButton.bottom + 10,
            width: view.width - 70,
            height: 20)
        
        orSignInWithLabel.frame = CGRect(
            x: 50,
            y: view.height - 170,
            width: view.width - 100,
            height: 20)
        
        let toggleXConstraint = NSLayoutConstraint(item: toggleButton, attribute: .right, relatedBy: .equal, toItem: passwordField, attribute: .right, multiplier: 1.0, constant: -20.0)
        let toggleYConstraint = NSLayoutConstraint(item: toggleButton, attribute: .centerY, relatedBy: .equal, toItem: passwordField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([toggleXConstraint, toggleYConstraint])
        
        let appleXConstraint = NSLayoutConstraint(item: appleButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let appleYConstraint = NSLayoutConstraint(item: appleButton, attribute: .top, relatedBy: .equal, toItem: orSignInWithLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
        NSLayoutConstraint.activate([appleXConstraint, appleYConstraint])
        
        let googleXConstraint = NSLayoutConstraint(item: googleButton, attribute: .right, relatedBy: .equal, toItem: appleButton, attribute: .left, multiplier: 1.0, constant: -24)
        let googleYConstraint = NSLayoutConstraint(item: googleButton, attribute: .top, relatedBy: .equal, toItem: orSignInWithLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
        NSLayoutConstraint.activate([googleXConstraint, googleYConstraint])
        
        let facebookXConstraint = NSLayoutConstraint(item: facebookButton, attribute: .left, relatedBy: .equal, toItem: appleButton, attribute: .right, multiplier: 1.0, constant: 24.0)
        let facebookYConstraint = NSLayoutConstraint(item: facebookButton, attribute: .top, relatedBy: .equal, toItem: orSignInWithLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
        NSLayoutConstraint.activate([facebookXConstraint, facebookYConstraint])
        
    }
    private func createBackButton() -> UIButton {
        let backButtonImage = UIImage(systemName: "arrow.backward")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .label
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return backButton
    }
    
    @objc private func didTapPasswordToggle() {
        passwordField.isSecureTextEntry.toggle()
    }
    
    @objc private func didTapSignIn() {
        usernameEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty else { return }
        guard let password = passwordField.text, !password.isEmpty, password.count >= 8 else { return }
        
        // sign in functionality
        
        // find out if user put either email or username to sign-in
        // I will improve this later
        
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            email = usernameEmail
        } else {
            username = usernameEmail
        }
        
        AuthManager.shared.signInUser(username: username, email: email, password: password) { [weak self] (signIn) in
            let spinner = UIViewController.displayLoading(withView: (self?.view)!)
            // this closure is background thread, and we want to update UI on the main thread.
            DispatchQueue.main.async {
                
                if signIn {
                    UIViewController.removeLoading(spinner: spinner)
                    
//                    self?.dismiss(animated: true, completion: nil)
//                    self?.navigationController?.
                    
                    
//                    let vc = TabBarViewController()
//                    let nav = UINavigationController(rootViewController: vc)
//                    vc.modalPresentationStyle = .fullScreen
//                    nav.navigationBar.prefersLargeTitles = true
//                    vc.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.createBackButton())
//                    self.present(vc, animated: true, completion: nil)
                    AuthManager.shared.userVerification { (verified) in
                        if verified {
                            self?.dismiss(animated: true, completion: nil)
                            self?.view.window?.rootViewController = TabBarViewController()
                            self?.view.window?.makeKeyAndVisible()
                        }
                        else {
                            let alert = Helper.errorAlert(title: "Email Verification", message: "Please verify your email")
                            self?.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                else {
                    // error
                    print("error")
                    UIViewController.removeLoading(spinner: spinner)
                    let alert = UIAlertController(title: "Sign In Error",
                                                  message: "Check your email or password.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel,
                                                  handler: nil))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    
    // this needs to be changed to navigate to the tabBar controller if auth passes
    @objc private func didTapForgotPassword() {
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

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapSignIn()
        }
        return true
    }
}
    
//    @IBAction func signinButtonPressed(_ sender: UIButton) {
//        guard let email = emailTextField.text else { return }
//        guard let password = passwordTextField.text else { return }
//
//        let spinner = UIViewController.displayLoading(withView: self.view)
//
//        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
//            guard let strongSelf = self else { return }
//
//            DispatchQueue.main.async {
//                UIViewController.removeLoading(spinner: spinner)
//            }
//
//            if error == nil {
//                DispatchQueue.main.async {
//                    Helper.login()
//                }
//            } else if let error = error {
//                var errorTitle = "Problem with Sign-in"
//                var errorMessage = "There was a problem logging in"
//
//                if let errorCode = AuthErrorCode(rawValue: error._code) {
//                    switch errorCode {
//
//                    case .wrongPassword:
//                        errorTitle = "Password is incorrect"
//                        errorMessage = "Please check the password again"
//
//                    case .invalidEmail:
//                        errorTitle = "Email Invalid"
//                        errorMessage = "Please enter a valid email address"
//
//                    default:
//                        break
//                    }
//                }
//
//                let alert = Helper.errorAlert(title: errorTitle, message: errorMessage)
//                strongSelf.present(alert, animated: true, completion: nil)
//            }
//
//        }
//
//
//    }
//    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
//    }
    
    
//}

