//
//  SignInViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/2/21.
//

import UIKit
//import FirebaseAuth

class SignInViewController: UIViewController {
    
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
    
    private let emailAddressField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = Constants.cornerRaius
        field.layer.masksToBounds = true
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = Constants.cornerRaius
        field.layer.masksToBounds = true
        return field
    }()
        
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = Constants.cornerRaius
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password", for: .normal)
        button.setTitleColor(.black , for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = Constants.cornerRaius
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        signInButton.addTarget(
            self,
            action: #selector(didTapSignIn),
            for: .touchUpInside)
        
        forgotPasswordButton.addTarget(
            self,
            action: #selector(didTapforgotPassword),
            for: .touchUpInside)
        
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainTitle.frame = CGRect(
            x: 70,
            y: view.safeAreaInsets.top + 70,
            width: view.width - 140,
            height: 80)
        
        subTitle.frame = CGRect(
            x: 70,
            y: mainTitle.bottom + 10,
            width: view.width - 140,
            height: 35)
        
        emailAddressField.frame = CGRect(
            x: 35,
            y: subTitle.bottom + 120,
            width: view.width - 70,
            height: 46)
        
        passwordField.frame = CGRect(
            x: 35,
            y: emailAddressField.bottom + 20,
            width: view.width - 70,
            height: 46)

        signInButton.frame = CGRect(
            x: 35,
            y: passwordField.bottom + 40,
            width: view.width - 70,
            height: 46)

        forgotPasswordButton.frame = CGRect(
            x: 35,
            y: signInButton.bottom + 15,
            width: view.width - 70,
            height: 46)
        
    }
    
    private func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(subTitle)
        view.addSubview(emailAddressField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(forgotPasswordButton)
    }
    
    private func createBackButton() -> UIButton {
        let backButtonImage = UIImage(systemName: "arrow.backward")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return backButton
    }
    
    @objc private func didTapSignIn() {
        let vc = RegistrationViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.prefersLargeTitles = true
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: createBackButton())
        present(nav, animated: true, completion: nil)
    }
    
    
    // this needs to be changed to navigate to the tabBar controller if auth passes
    @objc private func didTapforgotPassword() {
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

