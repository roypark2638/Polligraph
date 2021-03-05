//
//  SignInViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/2/21.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signinButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let spinner = UIViewController.displayLoading(withView: self.view)
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                UIViewController.removeLoading(spinner: spinner)
            }
            
            if error == nil {
                DispatchQueue.main.async {
                    Helper.login()
                }
            } else if let error = error {
                var errorTitle = "Problem with Sign-in"
                var errorMessage = "There was a problem logging in"
                
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    switch errorCode {
                    
                    case .wrongPassword:
                        errorTitle = "Password is incorrect"
                        errorMessage = "Please check the password again"
                        
                    case .invalidEmail:
                        errorTitle = "Email Invalid"
                        errorMessage = "Please enter a valid email address"
                        
                    default:
                        break
                    }
                }
                
                let alert = Helper.errorAlert(title: errorTitle, message: errorMessage)
                strongSelf.present(alert, animated: true, completion: nil)
            }
            
        }
        
        
    }
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
    }
    
    
}

