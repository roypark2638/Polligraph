//
//  NotificationTabsCollectionReusableView.swift
//  Polligraph
//
//  Created by Roy Park on 4/7/21.
//

import UIKit

class NotificationTabsCollectionReusableView: UICollectionReusableView {
    
    // MARK:- Properties
    static let identifier = "NotificationTabsCollectionReusableView"
    
    struct Constants {
        static let padding: CGFloat = 15
    }
    
    private let alertsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Alerts", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 18)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let inboxButton: UIButton = {
        let button = UIButton()
        button.setTitle("Inbox", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 18)
        return button
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        alertsButton.sizeToFit()
        let alertsButtonX = ((width/2)-alertsButton.width)/2
        alertsButton.frame = CGRect(
            x: alertsButtonX,
            y: Constants.padding,
            width: alertsButton.width,
            height: alertsButton.height
        )
        
        inboxButton.sizeToFit()
        inboxButton.frame = CGRect(
            x: alertsButtonX + (width / 2),
            y: Constants.padding,
            width: inboxButton.width,
            height: inboxButton.height
        )
    }
    
    // MARK: - Methods
    func configure() {
        
    }
    
    private func addSubviews() {
        addSubview(alertsButton)
        addSubview(inboxButton)
    }
    
    private func configureButton() {
        alertsButton.addTarget(
            self,
            action: #selector(didTapAlert),
            for: .touchUpInside
        )
        
        inboxButton.addTarget(
            self,
            action: #selector(didTapInbox),
            for: .touchUpInside
        )
    }
    
    
    @objc private func didTapAlert() {
        
    }
    
    @objc private func didTapInbox() {
        
    }
}
