//
//  AuthManager.swift
//  Polligraph
//
//  Created by Roy Park on 3/5/21.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    private let tabBarDelegate = TabBarDelegate()
    //MARK:- Public
    
    public var isSignedIn: Bool {
        if Auth.auth().currentUser == nil {
            return false
        }
        else {
            return true
        }
    }
        
    public func registerNewUser(email: String, password: String, confirmPassword: String) {
        
    }
    
    public func signInUser(email: String, password: String, confirmPassword: String) {
        
    }
}
