//
//  DatabaseManager.swift
//  Polligraph
//
//  Created by Roy Park on 3/6/21.
//

import FirebaseDatabase

final public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
//    static func safeEmail(emailAddress: String) -> String {
//        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
//        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
//        return safeEmail
//    }
    
    private let database = Database.database().reference()
    
    private init() {}
    
    enum DatabaseError: Error {
        case insertingError
    }
    
    //MARK:- Public
    
    /// this function will check underlying database for us
    /// no reason for auth manager to be aware of how that works
    /// simply ask dataManager, if auth manager can create an account with these parameters
    /// Check if username and email is available
    /// - Parameters
    ///     - email: String representing email
    ///     - username : String representing username
    ///     - completion: Async callback fro result if database entry succeeded
    public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
//        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        database.child("email").observeSingleEvent(of: .value) { (snapshot) in
            guard snapshot.value as? [String: Any] == nil else {
                completion(false)
                return
            }
            completion(true)
            
        }
        
    }
        
    
    /// We are not going to save the user password here. It's considered extremely bad practice
    /// Firebase will take care of storing the user password for us
    /// Insert new user data to database
    /// - parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry succeeded
    public func insertNewUser(
        with email: String,
        username: String,
        completion: @escaping (Result<String, Error>) -> Void) {
        /* current database structure
         users: {
            "RoyPark": {
                email
                posts: []
            }
         }
         */
        // users -> {}
        // get current users key
        // if that exists, insert new entry
        // else create root users
        database.child("users").observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard var usersDictionary = snapshot.value as? [String: Any] else {
                // Create users root node
                self?.database.child("users").setValue(
                    [
                        username: [
                            "email": email
                        ]
                    ]
                ) { (error, _) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    else {
                        completion(.success(email))
                        return
                    }
                }
                return
            }
            
            usersDictionary[username] = ["email": email]
            
            self?.database.child("users").setValue(usersDictionary, withCompletionBlock: { (error, _) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(email))
                return
            })
        }
    }
    
    public func getUsername(for email: String, completion: @escaping (String?) -> Void) {
        database.child("users").observeSingleEvent(of: .value) { (snapshot) in
            guard let users = snapshot.value as? [String: [String: Any]] else {
                completion(nil)
                return
            }
            
            for (username, value) in users {
                if value["email"] as? String == email {
                    completion(username)
                    break
                }
            }
        }
    }
    
}

