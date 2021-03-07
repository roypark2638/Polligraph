//
//  SignUpViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/2/21.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        let backButtonImage = UIImage(systemName: "arrow.backward")
//        let backButton = UIButton(type: .custom)
//        backButton.setImage(backButtonImage, for: .normal)
//        backButton.setTitleColor(.blue, for: .normal)
//        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
//        nav.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        
        if password != confirmPassword {
            Helper.errorAlert(title: "Password is not matched", message: "Please check password if they are matched")
        } else {
            let spinner = UIViewController.displayLoading(withView: self.view)
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
                
                guard let strongSelf = self else { return }
                
                DispatchQueue.main.async {
                    UIViewController.removeLoading(spinner: spinner)
                }
                
                if error == nil {
                    DispatchQueue.main.async {
                        //login
                    }
                } else if let error = error {
                    var errorTitle: String = "Login Error"
                    var errorMessage: String = "There was a problem logging in"
                    
//                    if let errorCode = AuthErrorCode(rawValue: error._code) {
//                        switch errorCode {
//                        case .
//                        }
//                    }
                }
            }
        }
    }
    
    
    
    


}
