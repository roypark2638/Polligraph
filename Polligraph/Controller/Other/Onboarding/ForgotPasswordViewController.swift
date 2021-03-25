//
//  ForgotPasswordViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/24/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    private let swipeBarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Swipe Bar")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        label.text = "Forgot Password"
        return label
    }()
    
    private let descriptionLabel1: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Enter the email address associated with your Polligraph account.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.textColor = .label
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let descriptionLabel2: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "We will send you a link to reset your password.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.textColor = .label
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    private let emailAddressField = AuthField(type: .email, title: "Email Address")
    private let confirmButton = AuthButton(type: .black, title: "Send Link")

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        
        confirmButton.addTarget(
            self,
            action: #selector(didTapSendLink),
            for: .touchUpInside
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpLayouts()
    }
    
    private func setUpLayouts() {
        swipeBarImageView.frame = CGRect(
            x: (view.width/2) - 25,
            y: view.top + 24,
            width: 50,
            height: 6
        )
        
        titleLabel.sizeToFit()
        
        titleLabel.frame = CGRect(
            x: view.width/2 - titleLabel.width/2,
            y: swipeBarImageView.bottom + 32,
            width: titleLabel.width,
            height: titleLabel.height
        )
        
        emailAddressField.frame = CGRect(
            x: 24,
            y: titleLabel.bottom + 56,
            width: view.width - 48,
            height: 50
        )
        
        descriptionLabel1.sizeToFit()
        descriptionLabel1.frame = CGRect(
            x: 24,
            y: emailAddressField.bottom + 40,
            width: view.width - 48,
            height: descriptionLabel1.height
        )
        
        descriptionLabel1.sizeToFit()
        descriptionLabel2.frame = CGRect(
            x: 24,
            y: descriptionLabel1.bottom + 32,
            width: view.width - 48,
            height: descriptionLabel1.height
        )
        
        confirmButton.frame = CGRect(
            x: 24,
            y: descriptionLabel2.bottom + 48,
            width: view.width - 48,
            height: 50
        )
    }
    
    private func addSubviews() {
        view.addSubview(swipeBarImageView)
        view.addSubview(titleLabel)
        view.addSubview(emailAddressField)
        view.addSubview(descriptionLabel1)
        view.addSubview(descriptionLabel2)
        view.addSubview(confirmButton)
    }

    
    @objc private func didTapSendLink() {
        
    }
}
