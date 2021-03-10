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
        
    /// Attempt to register New User to Firebase
    /// - parameters
    ///     username: String representing username
    ///     email: String representing email
    ///     password: String representing password
    ///     completion: Async callback to check if Firebase successfully create and insert the account
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /*
         - Check if username is available
         - Check if emial is available
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { (canCreate) in
            if canCreate {
                /*
                 - Create account in Firebase
                 - Insert account to database
                 */
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard result != nil, error == nil else {
                        // Firebase auth could not create an account
                        completion(false)
                        return
                    }
                    
                    // Successfully created an account, insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { (inserted) in
                        // success to insert into database
                        if inserted {
                            completion(true)
                            return
                        }
                        // failed to insert into database
                        else {
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                // either username or emial does not exist
                completion(false)
            }
        }
    }
    
    /// Attempt to sign in user to Firebase. It will take only one of username or email to sign in
    /// - parameters
    ///     username: optional String representing username
    ///     email: optional String representing email
    ///     password: String representing password
    ///     completion: Async callback to check if Firebase successfully sign in the user
    public func signInUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        // reason why using @escaping is we use completion inside of another closure and make it possible to escape the code with completion
        // if user put the email
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                guard result != nil, error == nil else {
                    // no result or there is error.
                    completion(false)
                    return
                }
            }
            // user successfully signin
            completion(true)
        }
        
        if let username = username {
            Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
                guard result != nil, error == nil else {
                    // no result or there is an error
                    completion(false)
                    return
                }
                // user successfully signin
                completion(true)
            }
        }
    }
    
    /// Attempt to sign out the user
    /// - parameters
    ///     completion: Async callback to check if Firebase successfully sign out the user
    public func signOutUser(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print("unable to signout the user")
            print(error)
            completion(false)
            return
        }
        
    }
}
