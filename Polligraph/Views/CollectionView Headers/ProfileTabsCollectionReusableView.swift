//
//  ProfileTabsCollectionReusableView.swift
//  Polligraph
//
//  Created by Roy Park on 3/26/21.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    static let identifier = "ProfileTabsCollectionReusableView"
    
    struct Constants {
        static let padding: CGFloat = 4
    }
    
    private let pollButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitle("Polls", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        return button
    }()
    
    private let savedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitle("Saved", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(pollButton)
        addSubview(savedButton)
        pollButton.addTarget(self, action: #selector(didTapPolls), for: .touchUpInside)
        savedButton.addTarget(self, action: #selector(didTapSaved), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        pollButton.sizeToFit()
        let pollsButtonX = ((width/2)-pollButton.width)/2
        pollButton.frame = CGRect(
            x: pollsButtonX,
            y: Constants.padding,
            width: pollButton.width,
            height: pollButton.height
        )
        
        savedButton.sizeToFit()
        savedButton.frame = CGRect(
            x: pollsButtonX + (width / 2),
            y: Constants.padding,
            width: savedButton.width,
            height: savedButton.height
        )
    }
    
    // MARK: - Methods
    
    // MARK: - Objc Methods
    @objc private func didTapPolls() {
        
    }
    
    @objc private func didTapSaved() {
        
    }
}
