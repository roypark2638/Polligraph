//
//  AlertCellViewModels.swift
//  Polligraph
//
//  Created by Roy Park on 4/21/21.
//

import Foundation

// ViewModel just for the cell
// Display the info and once we tap we need this info

struct CommentAlertCellViewModel {
    let username: String
    let profilePictureURL: URL?
    let postURL: URL?
    let date: Date
}

struct LikeCommentAlertCellViewModel {
    let username: String
    let profilePictureURL: URL?
    let postURL: URL?
    let date: Date
}

struct ReplyCommentAlertCellViewModel {
    let username: String
    let profilePictureURL: URL?
    let postURL: URL?
    let date: Date
}

struct FollowAlertCellViewModel {
    let username: String
    let profilePictureURL: URL?
    let isCurrentUserFollowing: Bool
    let date: Date
}
