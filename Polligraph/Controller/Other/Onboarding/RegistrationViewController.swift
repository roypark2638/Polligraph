//
//  SignUpViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/2/21.
//

import UIKit
import FirebaseAuth
import AuthenticationServices
import SafariServices


class RegistrationViewController: UIViewController {
    // MARK: - Properties

    var isUserAcceptAgreement = false
    
    struct Constants {
        static let cornerRadius = CGFloat(20.0)
    }
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's Get Started!"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textAlignment = .left
        label.textColor = .label
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let emailAddressField = TextField(type: .email, title: nil)
    private let usernameField = TextField(type: .username, title: nil)
    private let passwordField = TextField(type: .password, title: nil)

    
    private let toggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Eye"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let termsLabel: UILabel = {
        let label = UILabel()
        let text1 = "By signing up, you agree to our "
        let text2 = "Terms of Service "
        let text3 = "and acknowledge that you have read our "
        let text4 = "Privacy Policy "
        let text5 = "to learn how we collect, use and share your data."
        
        let text1Attribute = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 14)]
        let text2Attribute = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 14)]
        let text3Attribute = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 14)]
        let text4Attribute = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 14)]
        let text5Attribute = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 14)]
                        
        let attributedString1 = NSMutableAttributedString(string: text1, attributes: text1Attribute as [NSAttributedString.Key : Any])
        let attributedString2 = NSMutableAttributedString(string: text2, attributes: text2Attribute as [NSAttributedString.Key : Any])
        let attributedString3 = NSMutableAttributedString(string: text3, attributes: text3Attribute as [NSAttributedString.Key : Any])
        let attributedString4 = NSMutableAttributedString(string: text4, attributes: text4Attribute as [NSAttributedString.Key : Any])
        let attributedString5 = NSMutableAttributedString(string: text5, attributes: text5Attribute as [NSAttributedString.Key : Any])
        
//        attributedString2.addAttribute(.link, value: "https://www.google.com", range: NSMakeRange(0, attributedString2.length))
//        attributedString4.addAttribute(.link, value: "https://www.google.com", range: NSMakeRange(0, attributedString4.length))
//
//        attributedString2.accessibilityRespondsToUserInteraction = true
//        let term = UITapGestureRecognizer(target: self, action: #selector(didTouchTerms))
//        attributedString4.accessibilityRespondsToUserInteraction = true
//        let privacy = UITapGestureRecognizer(target: self, action: #selector(didTouchPrivacy))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        attributedString1.append(attributedString4)
        attributedString1.append(attributedString5)
        attributedString1.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString1.length))
        label.attributedText = attributedString1
                
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.textColor = .label
        return label
    }()
    
//    private let acceptLabelButton = AuthButton(type: .plain, title: "By signing up, you agree to our Terms of Service and acknowledge that you have read our Privacy Policy to learn how we collect, use and share your data.")
    
    private let createAccount = AuthButton(type: .black, title: "Create an Account")
    
    private let orCreateAccountWith: UILabel = {
        let label = UILabel()
        label.text = "Or Sign In With"
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        label.textAlignment = .center
        label.textColor = .label
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
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
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        toggleButton.addTarget(
            self,
            action: #selector(didTapPasswordToggle),
            for: .touchUpInside)
        
        createAccount.addTarget(
            self,
            action: #selector(didTapCreateAccount),
            for: .touchUpInside)
        
                
        addSubviews()
        configureField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headingLabel.frame = CGRect(
            x: 24,
            y: view.safeAreaInsets.top - 30,
            width: view.width - 48,
            height: 33)
        
        emailAddressField.frame = CGRect(
            x: 24,
            y: headingLabel.bottom + 56,
            width: view.width - 48,
            height: 50)
        
        usernameField.frame = CGRect(
            x: 24,
            y: emailAddressField.bottom + 16,
            width: view.width - 48,
            height: 50)
        
        passwordField.frame = CGRect(
            x: 24,
            y: usernameField.bottom + 16,
            width: view.width - 48,
            height: 50)
        
        let termsLabelSize = termsLabel.sizeThatFits(CGSize(width: view.width - 48, height: view.height))
        
        termsLabel.frame = CGRect(
            x: 24,
            y: passwordField.bottom + 24,
            width: termsLabelSize.width,
            height: termsLabelSize.height)
        
        createAccount.frame = CGRect(
            x: 24,
            y: termsLabel.bottom + 48,
            width: view.width - 48,
            height: 50)
        
        orCreateAccountWith.frame = CGRect(
            x: 24,
            y: view.height - view.safeAreaInsets.bottom - 160,
            width: view.width - 48,
            height: 30)
        
        let toggleXConstraint = NSLayoutConstraint(item: toggleButton, attribute: .right, relatedBy: .equal, toItem: passwordField, attribute: .right, multiplier: 1.0, constant: -20.0)
        let toggleYConstraint = NSLayoutConstraint(item: toggleButton, attribute: .centerY, relatedBy: .equal, toItem: passwordField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([toggleXConstraint, toggleYConstraint])
        
        let appleXConstraint = NSLayoutConstraint(item: appleButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let appleYConstraint = NSLayoutConstraint(item: appleButton, attribute: .top, relatedBy: .equal, toItem: orCreateAccountWith, attribute: .bottom, multiplier: 1.0, constant: 32.0)
        NSLayoutConstraint.activate([appleXConstraint, appleYConstraint])
        
        let googleXConstraint = NSLayoutConstraint(item: googleButton, attribute: .right, relatedBy: .equal, toItem: appleButton, attribute: .left, multiplier: 1.0, constant: -24)
        let googleYConstraint = NSLayoutConstraint(item: googleButton, attribute: .top, relatedBy: .equal, toItem: orCreateAccountWith, attribute: .bottom, multiplier: 1.0, constant: 32.0)
        NSLayoutConstraint.activate([googleXConstraint, googleYConstraint])
        
        let facebookXConstraint = NSLayoutConstraint(item: facebookButton, attribute: .left, relatedBy: .equal, toItem: appleButton, attribute: .right, multiplier: 1.0, constant: 24.0)
        let facebookYConstraint = NSLayoutConstraint(item: facebookButton, attribute: .top, relatedBy: .equal, toItem: orCreateAccountWith, attribute: .bottom, multiplier: 1.0, constant: 32.0)
        NSLayoutConstraint.activate([facebookXConstraint, facebookYConstraint])
    }
    
    
    // MARK: - Methods
    
    private func addSubviews() {
        view.addSubview(headingLabel)
        view.addSubview(emailAddressField)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(toggleButton)
        view.addSubview(termsLabel)
        view.addSubview(createAccount)
        view.addSubview(orCreateAccountWith)
        view.addSubview(googleButton)
        view.addSubview(appleButton)
        view.addSubview(facebookButton)
    }
    
    private func validateFields() -> String? {
        
        // Check all fields are checked in
        if emailAddressField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        
        if ((emailAddressField.text?.contains("@")) == nil), ((emailAddressField.text?.contains(".")) == nil) {
            return "Please check the email address"
        }
        
        // Check if the password is matched with the rules.
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !Helper.isPasswordValid(password: cleanedPassword) {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    private func configureField() {
        emailAddressField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTouchKeyboardDone))
        ]
        
        toolBar.sizeToFit()
        emailAddressField.inputAccessoryView = toolBar
        usernameField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
    }
    
    // MARK: - Objc Methods
    
    @objc private func didTouchKeyboardDone() {
        emailAddressField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @objc private func didTapPasswordToggle() {
        passwordField.isSecureTextEntry.toggle()
    }
    
    @objc private func didTapCreateAccount() {
        didTouchKeyboardDone()
                        
        let errorMessage = validateFields()
        
        if errorMessage != nil {
            let alert = Helper.errorAlert(title: "Error", message: errorMessage!)
            self.present(alert, animated: true, completion: nil)
        }

        else {
            
        guard let emailAddress = emailAddressField.text, !emailAddress.isEmpty,
              let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, password.count >= 8 else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: emailAddress, password: password) { [weak self] (registered) in
            let spinner = UIViewController.displayLoading(withView: (self?.view)!)
            // we are going to update our UI so use DispatchQueue
            DispatchQueue.main.async {
                // success to register an account
                switch registered {
                case .success:
                    AuthManager.shared.sendEmailVerification() { sentEmail in
                        // successfully sent the email to the link
                        if sentEmail {

                        }
                        else {
                            // error to send an email
                            let alert = Helper.errorAlert(title: "Error Email Verification!", message: "Something went wrong with email verification link. Please try again.")
                            self?.present(alert, animated: true, completion: nil)
                        }
                        
                        UIViewController.removeLoading(spinner: spinner)
                        let vc = EmailVerificationViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true, completion: nil)
    //                    self.dismiss(animated: true, completion: nil)
                        return
                    }
                case .failure(let error):
                    UIViewController.removeLoading(spinner: spinner)
                    let alert = Helper.errorAlert(title: "Temp Error Duplicate", message: "Email or username are already taken (Temp).")
                    self?.present(alert, animated: true, completion: nil)
                }
//                if registered {
                    
//                    let alert = Helper.errorAlert(title: "Verification Link Sent!", message: "Please check your email inbox associated with \(emailAddress) for the verification link.")
//                    self.present(alert, animated: true, completion: nil)

//                }
                // fail to register an account
//                else {
                    // error to create an account
                    // TODO: databaseManager to check if the user can create account with email and username
                    
//                }
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
//                    if let errorCode = AuthErrorCode(rawValue: error._code) {
//                        switch errorCode {
//                        case .
//                        }
//                    }
//                }
//            }
//        }
//    }

}

// MARK: - UITextFieldDelegate

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
