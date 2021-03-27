//
//  UserPost.swift
//  Polligraph
//
//  Created by Roy Park on 3/5/21.
//

import Foundation

enum UserPostType {
    case photo, video
}

enum Gender {
    case male, female, other
}

struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdData: Date
    let taggedUser: [String]
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
//    let birthDate: Date? // I need to change this not to be null later
    let gender: Gender
    let counts: UserCount
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostLike {
    let username: String
    let commentIdentifier: String
}
