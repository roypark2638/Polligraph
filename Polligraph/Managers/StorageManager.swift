//
//  StorageManager.swift
//  Polligraph
//
//  Created by Roy Park on 3/6/21.
//

import FirebaseStorage

public class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    private let storage = Storage.storage().reference()
    
    // MARK: Public
    
    public func uploadProfilePicture(
        username: String,
        data: Data?,
        completion: @escaping (Bool) -> Void ) {
        guard let data = data else {
            completion(false)
            return
        }
        
        storage.child("\(username)/profile_picture.png").putData(data, metadata: nil) { _, error in
            completion(error == nil)
        }
    }
    
}
