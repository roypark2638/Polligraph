//
//  AuthButton.swift
//  Polligraph
//
//  Created by Roy Park on 3/21/21.
//

import UIKit

class AuthButton: UIButton {
    
    enum ButtonType {
        case black
        case secondary
        case plain
    }
    
    private let type: ButtonType

    init(type: ButtonType, title: String) {
        self.type = type
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureButton() {
        titleLabel?.numberOfLines = 1
        titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        titleLabel?.sizeToFit()
        titleLabel?.adjustsFontSizeToFitWidth = true
        layer.cornerRadius = 20.0
        titleLabel?.textAlignment = .center
        
        switch type {
        case .black:
            backgroundColor = .black
            setTitleColor(.systemBackground, for: .normal)
        case .secondary:
            backgroundColor = .secondarySystemBackground
            setTitleColor(.label, for: .normal)
            
        case .plain:
            titleLabel?.numberOfLines = 0
            backgroundColor = .clear
            titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
            setTitleColor(.label, for: .normal)

        }
    }
    
}
