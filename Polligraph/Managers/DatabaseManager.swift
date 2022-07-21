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
        case gettingPosts
    }
    
    //MARK:- Public
    
 
    public func getAlerts(completion: @escaping ([Alert]) -> Void) {
        completion(Alert.mockData())
    }
    
    
    public func markAlertAsHidden(alertID: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    public func getPosts(
        for username: String,
        completion: @escaping (Result<[Post], Error>) -> Void
    ) {
        let path = "users/\(username)/posts"
        let reference = database.child(path).observeSingleEvent(of: .value) { snapshot in
            guard let postsDictionary = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.gettingPosts))
                return
            }
            print("\n\n")
            print(postsDictionary)
            print("\n\n")
            let posts: [Post] = postsDictionary.compactMap({
                let post: Post = Post(
                    id: $0["id"] as? String ?? "\(username)_\(UUID().uuidString)" ,
                    caption: $0["caption"] as? String ?? "",
                    postedDate: $0["postedDate"] as? String ?? String.date(with: Date()),
                    postURLString: $0["postURLString"] as? String ?? "postURLString",
                    likers: $0["likers"] as? [String] ?? [""]
                )
            
                return post
            })
            print("Printing posts \n \(posts) \n")
        }
    }

    
//    public func posts(
//        for username: String,
//        completion: @escaping (Result<[Post], Error>) -> Void
//    ) {
//        let reference = database.child("users/\(username)").
//    }
}

// MARK: - Account Management

extension DatabaseManager {
    /// this function will check underlying database for us
    /// no reason for auth manager to be aware of how that works
    /// simply ask dataManager, if auth manager can create an account with these parameters
    /// Check if username and email is available
    /// - Parameters
    ///     - email: String representing email
    ///     - username : String representing username
    ///     - completion: Async callback for result if database entry succeeded
    public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
//        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        database.child("email").observeSingleEvent(of: .value) { (snapshot) in
            guard !snapshot.exists() else {
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
    
}


// MARK: - Get User Info

extension DatabaseManager {
    
    public func getUsername(for email: String, completion: @escaping (String?) -> Void) {
        database.child("users").observeSingleEvent(of: .value) { (snapshot) in
            guard let users = snapshot.value as? [String: [String: Any]] else {
                completion(nil)
                return
            }
            
            for (username, value) in users {
                if value["email"] as? String == email {
                    completion(username)
                    return
                }
            }
        }
    }
    
    public func getUserInfo(
        username: String,
        completion: @escaping (UserInfo?) -> Void
    ) {
        let path = "users/\(username)/information"
        database.child(path).observeSingleEvent(of: .value) { snapshot in
            guard let userInfoDictionary = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            print(userInfoDictionary)
            guard let username = userInfoDictionary["username"] as? String,
                  let bio = userInfoDictionary["username"] as? String,
                  let displayName = userInfoDictionary["display_name"] as? String else {
                print("Failed to convert userInfoDic from getUserInfo")
                completion(nil)
                return
            }
            let userInfo = UserInfo(username: username, displayName: displayName, bio: bio)
            completion(userInfo)
//            completion(userInfo)
//
//            let models: [UserInfo] = information.compactMap({
//                let displayName = $0["displayName"] ?? ""
//                let userInfo = UserInfo(username: username, displayName: <#T##String#>, bio: <#T##String#>)
//            })
            
        }
    }
    
    public func setUserInfo(
        userInfo: UserInfo,
        completion: @escaping (Bool) -> Void
    ) {
        guard let data = userInfo.asDictionary() else {
            completion(false)
            return
        }
//        let username = UserDefaults.standard.
        
        let path = "users/\(userInfo.username)/information"
        
        print("the user info: \(userInfo)")
        print("The path : \(path)")
        
        database.child(path).setValue(data) { error, ref in
            completion(error == nil)
        }
    }
    
    public func isFollowing(targetUsername: String, completion: @escaping (Bool) -> Void) {
        guard let currentUsername = UserDefaults.standard.string(forKey: "username")?.lowercased() else {
            completion(false)
            return
        }
        let path = "users/\(targetUsername)/followers/\(currentUsername)"
        database.child(path).observeSingleEvent(of: .value) { snapshot in
            // if user exist, then return true, otherwise return false
            completion(snapshot.exists())
        }
    }
}
