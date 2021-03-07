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

//    private let mainTitle: UILabel = {
//        let label = UILabel()
//        label.text = "Let's Get Started!"
//        label.font = label.font.withSize(30)
//        label.textAlignment = .left
//        label.backgroundColor = .systemBlue
//        label.textColor = .black
//        label.sizeToFit()
//        label.numberOfLines = 1
//        label.adjustsFontSizeToFitWidth = true
//        return label
//    }()
    
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
        
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        mainTitle.frame = CGRect(
//            x: 35,
//            y: view.safeAreaInsets.top,
//            width: view.width - 70,
//            height: 30)
        
        emailAddressField.frame = CGRect(
            x: 35,
            y: view.safeAreaInsets.top + 30,
            width: view.width - 70,
            height: 46)
        
        passwordField.frame = CGRect(
            x: 35,
            y: emailAddressField.bottom + 20,
            width: view.width - 70,
            height: 46)
        
        confirmPasswordField.frame = CGRect(
            x: 35,
            y: passwordField.bottom + 20,
            width: view.width - 70,
            height: 46)
        
        acceptButton.frame = CGRect(
            x: 35,
            y: confirmPasswordField.bottom + 30,
            width: 23,
            height: 23)
        
        acceptLabel.frame = CGRect(
            x: acceptButton.right + 18,
            y: confirmPasswordField.bottom + 20,
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
//        view.addSubview(mainTitle)
        view.addSubview(emailAddressField)
        view.addSubview(passwordField)
        view.addSubview(confirmPasswordField)
        view.addSubview(acceptButton)
        view.addSubview(acceptLabel)
        view.addSubview(createAccount)
        view.addSubview(orCreateAccountWith)
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
