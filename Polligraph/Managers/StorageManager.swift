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
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToDownloadURL
    }
    
    public typealias UploadProfilePictureCompletion = (Result<String, Error>) -> Void
    
    public func uploadProfilePicture(
        username: String,
        data: Data,
        completion: @escaping UploadProfilePictureCompletion
    ) {
        let path = "images/\(username)/profile_picture.png"
        
        storage.child(path).putData(data, metadata: nil) { [weak self] _, error in
            guard error == nil else {
                print("failed to upload data to firebase for picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self?.storage.child(path).downloadURL { url, error in
                guard let url = url, error == nil else {
                    if let error = error {
                        print("Failed to download URL with an error: \(error)")
                        completion(.failure(error))
                        return
                    }
                    print("Failed to download URL")
                    completion(.failure(StorageErrors.failedToDownloadURL))
                    return
                }
                
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            }
        }
    }
    
    public func getProfilePictureURL(for username: String, completion: @escaping (URL?) -> Void) {
        storage.child("images/\(username)/profile_picture.png").downloadURL { url, error in
            completion(url)
            return
        }
    }
}
