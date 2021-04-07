//
//  TextField.swift
//  Polligraph
//
//  Created by Roy Park on 3/21/21.
//

import UIKit

// Make this to be re-usable
class TextField: UITextField {
    
    enum FieldType {
        case username
        case email
        case password
        case other
        
        var title: String {
            switch self {
            case .username: return "Username"
            case .email: return "Email"
            case .password: return "Password"
            case .other: return ""
            }
        }
    }
    
    private let type: FieldType

    init(type: FieldType, title: String?) {
        self.type = type
        super.init(frame: .zero)
        placeholder = type.title
        if let safeTitle = title {
            placeholder = safeTitle
        }
        configureField()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureField() {
        backgroundColor = .secondarySystemBackground
//        placeholder = type.title
        layer.cornerRadius = 20.0
        layer.masksToBounds = true
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        
        font = UIFont(name: "Roboto-Bold", size: 16)
        if type == .username {
            
        }
        else if type == .email {
            keyboardType = .emailAddress
            textContentType = .emailAddress
        }
        else if type == .password {
            isSecureTextEntry = true
            textContentType = .oneTimeCode
        }
        
        else if type == .other {
            font = UIFont(name: "Roboto-Regular", size: 16)
            placeholder = ""
        }
    }
}
