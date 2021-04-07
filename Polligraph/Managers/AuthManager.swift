//
//  AuthManager.swift
//  Polligraph
//
//  Created by Roy Park on 3/5/21.
//

import Firebase
import GoogleSignIn

public class AuthManager{
    static let shared = AuthManager()
    
    private let tabBarDelegate = TabBarDelegate()
    
    public enum SignInMethod {
        case email
//        case google
//        case apple
//        case facebook
    }
    
    enum AuthError: Error {
        case SignInFailed
        case SignUpFailed
    }
    
    //MARK:- Public
    
    
    /// Check if user is signed in or not.
    /// - Returns: Boolean True / False
    public func isSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    public func isVerified() -> Bool {
        if let currentUser = Auth.auth().currentUser {
            return currentUser.isEmailVerified
        } else {
            return false
        }
    }
        
    /// Attempt to register New User to Firebase
    /// - parameters
    ///     username: String representing username
    ///     email: String representing email
    ///     password: String representing password
    ///     completion: Async callback to check if Firebase successfully create and insert the account
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        /*
         - Check if username is available
         - Check if email is available
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
                        if let error = error {
                            print("From AuthManager Error exist")
                            print(error.localizedDescription)
                            completion(.failure(error))
                            return
                        }
                        else {
                            print("From AuthManager No result but no error")
                            completion(.failure(AuthError.SignUpFailed))
                            return
                        }
                    }
                    
                    // Successfully created an account, insert into database
                    UserDefaults.standard.setValue(username, forKey: "username")
                    
                    DatabaseManager.shared.insertNewUser(with: email, username: username, completion: completion)
                }
            }
        }
    }
    
//    public func insertUserIntoDatabase(username: String, email: String, completion: @escaping (Bool) -> Void) {
//        /*
//         - Check if username is available
//         - Check if email is available
//         */
//        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { (canCreate) in
//            if canCreate {
//                /*
//                 - Create account in Firebase
//                 - Insert account to database
//                 */
//                    // Successfully created an account, insert into database
//                    DatabaseManager.shared.insertNewUser(with: email, username: username) { (inserted) in
//                        // success to insert into database
//                        if inserted {
//                            completion(true)
//                            return
//                        }
//                        // failed to insert into database
//                        else {
//                            completion(false)
//                            return
//                        }
//                    }
//                }
//
//            else {
//                // either username or email does not exist
//                completion(false)
//            }
//        }
//    }
    
    
    /// Send a email verification to the user
    /// - Parameter
    /// completion: async callback to send the email to the user
    public func sendEmailVerification(completion: @escaping (Bool) -> Void) {
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            if error == nil {
                // success to send the email
                completion(true)
                return
            }
            else {
                // error occurs to send the email
                completion(false)
                return
            }
        })
    }
    
    
    /// Check if user verify the email address
    /// - Parameter completion: Async callback to check if user verify the email
    public func userVerification(completion: @escaping (Bool) -> Void) {
//        let user = Auth.auth().currentUser
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                user.reload() { error in
                    if user.isEmailVerified {
                        completion(true)
                        return
                    }
                    else {
                        completion(false)
                        return
                    }
                }
                
            }
        }
    }
    
    /// Attempt to sign in user to Firebase. It will take only one of username or email to sign in
    /// - parameters
    ///     username: optional String representing username
    ///     email: optional String representing email
    ///     password: String representing password
    ///     completion: Async callback to check if Firebase successfully sign in the user
    public func signInUser(with signInMethod: SignInMethod, username: String?, email: String?, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        // reason why using @escaping is we use completion inside of another closure and make it possible to escape the code with completion
        // if user put the email
        switch signInMethod {
        case .email:
            // user tries to sign in with email address
            if let email = email {
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    guard result != nil, error == nil else {
                        if let error = error {
                            // error exist
                            completion(.failure(error))
                            return
                        }
                        else {
                            // no error but no result
                            completion(.failure(AuthError.SignInFailed))
                            return
                        }
                    }
                }
                // user successfully sign in
                completion(.success(email))
            }
            
            // user tries to sign in with username
            if let username = username {
                Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
                    guard result != nil, error == nil else {
                        if let error = error {
                            // error exist
                            completion(.failure(error))
                            return
                        }
                        else {
                            // no error but no result
                            completion(.failure(AuthError.SignInFailed))
                            return
                        }
                    }
                }
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
            print("unable to sign out the user")
            print(error)
            completion(false)
            return
        }
        
    }
    
    public func googleSignIn(with credential: AuthCredential, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                completion(false)
                return
            }
            // user is signed in with Firebase
            completion(true)
        }
            
        
    }
}

