//
//  SignInViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/2/21.
//

import UIKit
//import FirebaseAuth

class SignInViewController: UIViewController {
    
    private let emailTextField: UITextField = {
        return UITextField()
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true        
        return textField
    }()
    
    private let signInButton: UITextField = {
        return UITextField()
    }()
    
    private let CreateAccountButton: UITextField = {
        return UITextField()
    }()
    
    private let headerView: UIView = {
        return UIView()
    }()
    
    private let termsButton: UIButton = {
        return UIButton()
    }()
    
    private let privacyButton: UIButton = {
        return UIButton()
    }()
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.backItem?.title = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        addSubviews()
        title = "Sign In Page"
        view.backgroundColor = .red
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        // assign frames
//        headerView.frame = CGRect(x: 0,
//                                  y: view.safeAreaInsets.top,
//                                  width: view.width,
//                                  height: 200)
//    }
    
    private func addSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(CreateAccountButton)
        view.addSubview(headerView)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        
    }
    
    @objc private func didTouchSignInButton() {
        
    }
    
    @objc private func didTouchCreateAccountButton() {
        
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
    
    
}

