//
//  DatabaseManager.swift
//  Polligraph
//
//  Created by Roy Park on 3/6/21.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let reference = Database.database().reference()
    
    //MARK: Public
    
    // this function will check underlying database for us
    // no reason for auth manager to be aware of how that works
    // simply ask datamanager, if auth manager can create an account with these parameters
    /// Check if username and email is available
    /// - Parameters
    ///     - email: String representing email
    ///     - username : String representing username
    ///     - completion: Async callback fro result if database entry succeded
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    // We are not going to save the user password here. It's considered extremely bad practice
    // Firebase will take care of storing the user password for us
    /// Insert new user data to database
    /// - parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry succeded
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        reference.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                // successed to insert new user
                completion(true)
                return
            }
            else {
                // failed with inserting new user
                completion(false)
                return
            }
        }
        return
    }
    
    
    
}
