//
//  SignInViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/2/21.
//
import GoogleSignIn
import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    // MARK: - Properties

    struct Constants {
        static let cornerRadius = CGFloat(20.0)
    }
    
    // Create anonymous closures
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome Back!"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textAlignment = .left
        label.textColor = .label
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let usernameEmailField = AuthField(type: .email, title: "Email Address or Username")
    private let passwordField = AuthField(type: .password, title: nil)
    
    private let toggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Eye"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signInButton = AuthButton(type: .black, title: "Sign In")
    private let forgotPasswordButton = AuthButton(type: .boldPlain, title: "Forgot Password")
    
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
//        button.style = .iconOnly
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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance().signIn()
        
        view.backgroundColor = .systemBackground
        
        setupButtonActions()
        configureField()
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpLayout()
    }
    
    // MARK: - Methods
    
    private func configureField() {
        usernameEmailField.delegate = self
        passwordField.delegate = self
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTouchKeyboardDone))
        ]
        
        toolBar.sizeToFit()
        usernameEmailField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
    }
    
    private func addSubviews() {
        view.addSubview(headingLabel)
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
        
        googleButton.addTarget(
            self,
            action: #selector(didTapGoogle),
            for: .touchUpInside)
        
        appleButton.addTarget(
            self,
            action: #selector(didTapApple),
            for: .touchUpInside)
    }
    
    private func setUpLayout() {
        headingLabel.frame = CGRect(
            x: 24,
            y: view.safeAreaInsets.top - 30,
            width: view.width - 48,
            height: 33)
        
        usernameEmailField.frame = CGRect(
            x: 24,
            y: headingLabel.bottom + 56,
            width: view.width - 48,
            height: 50)
        
        passwordField.frame = CGRect(
            x: 24,
            y: usernameEmailField.bottom + 17,
            width: view.width - 48,
            height: 50)

        signInButton.frame = CGRect(
            x: 24,
            y: passwordField.bottom + 40,
            width: view.width - 48,
            height: 50)

        forgotPasswordButton.frame = CGRect(
            x: 24,
            y: signInButton.bottom + 20,
            width: view.width - 48,
            height: 20)
        
        orSignInWithLabel.frame = CGRect(
            x: 50,
            y: view.height - view.safeAreaInsets.bottom - 160,
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
        let backButtonImage = UIImage(systemName: "Back Arrow")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .label
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return backButton
    }
    
    // MARK: - Objc Methods
    @objc private func didTouchKeyboardDone() {
        usernameEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    @objc private func didTapPasswordToggle() {
        passwordField.isSecureTextEntry.toggle()
    }
    
    @objc private func didTapSignIn() {
        didTouchKeyboardDone()
        
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
        let vc = ForgotPasswordViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.backgroundColor = .clear
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: createBackButton())
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func didTapGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc private func didTapApple() {
        performAppleSignIn()
    }
    
    @objc private func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    private func performAppleSignIn() {
        
    }
}

// MARK: - UITextFieldDelegate

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

