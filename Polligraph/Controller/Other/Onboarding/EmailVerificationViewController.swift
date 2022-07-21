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

    private let mailView: UIView = {
        let mail = UIView()
        mail.clipsToBounds = true
        let mailImageView = UIImageView(image: UIImage(named: "Mail UI"))
        mailImageView.contentMode = .scaleAspectFit
        mailImageView.layer.masksToBounds = true
        mail.layer.masksToBounds = true

        mail.addSubview(mailImageView)
        return mail
    }()
    
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
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = 3
        
        regularString.append(attributedString)
        regularString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, regularString.length))
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
        let attributedString = NSMutableAttributedString(string: "Make sure to check your Spam or Junk folder if you can't find the verification email.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.textColor = .lightGray
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
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
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        
        signInButton.addTarget(self, action: #selector(didTouchSignIn), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .systemBackground
        setUpLayout()
        
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
    
    private func setUpLayout() {

        
        titleLabel.frame = CGRect(
            x: 24,
            y: view.safeAreaInsets.bottom + 80,
            width: view.width - 48,
            height: 33
        )
        
        let imageWidth = view.width/2.8
        let imageHeight = view.width/5.6
        
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
            height: 44
        )
    
        subLabel3.frame = CGRect(
            x: 24,
            y: subLabel2.bottom + 40,
            width: view.width - 48,
            height: 44
        )

        subLabel4.frame = CGRect(
            x: 24,
            y: subLabel3.bottom + 70,
            width: view.width - 48,
            height: 22
        )

        signInButton.frame = CGRect(
            x: 24,
            y: subLabel4.bottom + 32,
            width: view.width - 48,
            height: 50
        )
    }
    
    // MARK: - Objc Methods
    
    @objc private func didTouchSignIn() {
        let vc = OnboardingViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }


}
