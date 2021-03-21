//
//  OneLastStepViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/16/21.
//

import UIKit
import FirebaseAuth

class EmailVerificationViewController: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "One Last Step!"
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private let mailView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Mail UI")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
//
//    private let mailView: UIView = {
//        let mail = UIView()
//        mail.clipsToBounds = true
//        let mailImageView = UIImageView(image: UIImage(named: "Mail UI"))
//        mailImageView.contentMode = .scaleAspectFit
//        mailImageView.layer.masksToBounds = true
//        mail.layer.masksToBounds = true
//
//        mail.addSubview(mailImageView)
//        return mail
//    }()
    
    private let subLabel1: UILabel = {
        let label = UILabel()
        label.text = "We've sent you a verification link!"
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.textColor = .label
        return label
    }()
    
    private let subLabel2: UILabel = {
        let label = UILabel()
        let regularText = "Please check your email inbox associated with: "
        let regularAttribute = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 16)]
        let regularString = NSMutableAttributedString(string: regularText, attributes: regularAttribute as [NSAttributedString.Key : Any])
        let email = Auth.auth().currentUser?.email ?? ""
        let boldFont = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 16)]
        let attributedString = NSMutableAttributedString(string: email, attributes: boldFont as [NSAttributedString.Key : Any])
                
        regularString.append(attributedString)
        label.attributedText = regularString
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.textColor = .label
        return label
    }()
    
    private let subLabel3: UILabel = {
        let label = UILabel()
        label.text = "Make sure to check your Spam or Junk folder if you can't find the verification email."
        label.textColor = .lightGray
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
//        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let subLabel4: UILabel = {
        let label = UILabel()
        label.text = "Already verified?"
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textColor = .label
        label.numberOfLines = 1
        label.textAlignment = .center
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let signInButton = AuthButton(type: .black, title: "Sign In")
//    private let signInButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Sign In", for: .normal)
//        button.backgroundColor = .systemBackground
//        button.setTitleColor(.label, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
//        button.titleLabel?.textAlignment = .center
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        
        signInButton.addTarget(self, action: #selector(didTouchSignIn), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .systemBackground
        addLayouts()
        
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(mailView)
        view.addSubview(subLabel1)
        view.addSubview(subLabel2)
        view.addSubview(subLabel3)
        view.addSubview(subLabel4)
        view.addSubview(signInButton)
    }
    
    private func addLayouts() {
        let imageWidth = view.width/2.8
        let imageHeight = view.width/5.6
        
        titleLabel.frame = CGRect(
            x: 24,
            y: view.safeAreaInsets.bottom + 80,
            width: view.width - 48,
            height: 33
        )
        
        mailView.frame = CGRect(
            x: (view.width-imageWidth)/2,
            y: titleLabel.bottom + 32,
            width: imageWidth,
            height: imageHeight

        )
        
        subLabel1.frame = CGRect(
            x: 24,
            y: mailView.bottom + 40,
            width: view.width - 48,
            height: 22
        )

        subLabel2.frame = CGRect(
            x: 24,
            y: subLabel1.bottom + 40,
            width: view.width - 48,
            height: 22
        )
        
        subLabel3.sizeToFit()
        let titleLabelSize = subLabel3.sizeThatFits(CGSize(width: imageWidth, height: view.height))

        subLabel3.frame = CGRect(
            x: 24,
            y: subLabel2.bottom + 40,
            width: view.width - 48,
            height: titleLabelSize.height
        )

        subLabel4.frame = CGRect(
            x: 24,
            y: subLabel3.bottom + 40,
            width: view.width - 48,
            height: 22
        )

        signInButton.frame = CGRect(
            x: 24,
            y: subLabel4.bottom + 40,
            width: view.width - 48,
            height: 50
        )
    }
    
    
    @objc private func didTouchSignIn() {
        let vc = OnboardingViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }


}
