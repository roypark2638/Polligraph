//
//  SignUpViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/2/21.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius = CGFloat(8.0)
    }
    
    private let emailAddressField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))        
        field.backgroundColor = .secondarySystemBackground
        field.textColor = .black
        field.layer.cornerRadius = Constants.cornerRadius
        return field
    }()
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.backgroundColor = .secondarySystemBackground
        field.textColor = .black
        field.layer.cornerRadius = Constants.cornerRadius
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.returnKeyType = .next
        field.isSecureTextEntry = true
        field.leftViewMode = .always
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.backgroundColor = .secondarySystemBackground
        field.textColor = .black
        field.layer.cornerRadius = Constants.cornerRadius
        return field
    }()
    
    private let confirmPasswordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Confirm Password"
        field.returnKeyType = .continue
        field.isSecureTextEntry = true
        field.leftViewMode = .always
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.backgroundColor = .secondarySystemBackground
        field.textColor = .black
        field.layer.cornerRadius = Constants.cornerRadius
        return field
    }()
    
    private let acceptButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        return button
    }()
    
    private let acceptLabel: UILabel = {
        let label = UILabel()
        label.text = "I accept the Polligraph User Agreement and have read the Privacy Pollicy."
        label.numberOfLines = 0
        label.font = label.font.withSize(16)
        label.textAlignment = .left
        label.backgroundColor = .systemBlue
        label.textColor = .black
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let createAccount: UIButton = {
        let button = UIButton()
        button.setTitle("Create an Account", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let orCreateAccountWith: UILabel = {
        let label = UILabel()
        label.text = "Or create an account with"
        label.numberOfLines = 1
        label.font = label.font.withSize(16)
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        label.textColor = .black
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Let's Get Started!"
        
        emailAddressField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
                
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        emailAddressField.frame = CGRect(
            x: 35,
            y: view.safeAreaInsets.top + 30,
            width: view.width - 70,
            height: 46)
        
        usernameField.frame = CGRect(
            x: 35,
            y: emailAddressField.bottom + 20,
            width: view.width - 70,
            height: 46)
        
        passwordField.frame = CGRect(
            x: 35,
            y: usernameField.bottom + 20,
            width: view.width - 70,
            height: 46)
        
        acceptButton.frame = CGRect(
            x: 35,
            y: passwordField.bottom + 30,
            width: 23,
            height: 23)
        
        acceptLabel.frame = CGRect(
            x: acceptButton.right + 18,
            y: passwordField.bottom + 20,
            width: view.width - 112,
            height: 40)
        
        createAccount.frame = CGRect(
            x: 35,
            y: acceptLabel.bottom + 80,
            width: view.width - 70,
            height: 46)
        
        orCreateAccountWith.frame = CGRect(
            x: 35,
            y: view.height - view.safeAreaInsets.bottom - 150,
            width: view.width - 70,
            height: 30)
    }
    
    private func addSubviews() {
        view.addSubview(emailAddressField)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(acceptButton)
        view.addSubview(acceptLabel)
        view.addSubview(createAccount)
        view.addSubview(orCreateAccountWith)
    }
    
//    private func createBackButton() -> UIButton {
//        let backButtonImage = UIImage(systemName: "arrow.backward")
//        let backButton = UIButton(type: .custom)
//        backButton.setImage(backButtonImage, for: .normal)
//        backButton.tintColor = .black
//        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
//        return backButton
//    }
    
    @objc private func didTapCreateAccount() {
        emailAddressField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let emailAddress = emailAddressField.text, !emailAddress.isEmpty,
              let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, password.count >= 8 else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: emailAddress, password: password) { (registered) in
            let spinner = UIViewController.displayLoading(withView: self.view)
            // we are going to update our UI so use DispatchQueue
            DispatchQueue.main.async {
                // success to register an account
                if registered {
                    UIViewController.removeLoading(spinner: spinner)
                    self.dismiss(animated: true, completion: nil)
                    return
                }
                // fail to register an account
                else {
                    return
                }
            }
        }
    }
    
    
    
//    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
//        guard let email = emailTextField.text else { return }
//        guard let password = passwordTextField.text else { return }
//        guard let confirmPassword = confirmPasswordTextField.text else { return }
//
//        if password != confirmPassword {
//            Helper.errorAlert(title: "Password is not matched", message: "Please check password if they are matched")
//        } else {
//            let spinner = UIViewController.displayLoading(withView: self.view)
//            Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
//
//                guard let strongSelf = self else { return }
//
//                DispatchQueue.main.async {
//                    UIViewController.removeLoading(spinner: spinner)
//                }
//
//                if error == nil {
//                    DispatchQueue.main.async {
//                        //login
//                    }
//                } else if let error = error {
//                    var errorTitle: String = "Login Error"
//                    var errorMessage: String = "There was a problem logging in"
//
////                    if let errorCode = AuthErrorCode(rawValue: error._code) {
////                        switch errorCode {
////                        case .
////                        }
////                    }
//                }
//            }
//        }
//    }

}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailAddressField {
            usernameField.becomeFirstResponder()
        }
        else if textField == usernameField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapCreateAccount()
        }
        
        return true
    }
}
