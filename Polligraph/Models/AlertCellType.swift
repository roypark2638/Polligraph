//
//  AlertCellType.swift
//  Polligraph
//
//  Created by Roy Park on 4/21/21.
//

import Foundation

enum AlertCellType {
    case userFollow(viewModel: FollowAlertCellViewModel)
    case postComment(viewModel: CommentAlertCellViewModel)
    case postCommentLike(viewModel: LikeCommentAlertCellViewModel)
    case postCommentReply(viewModel: ReplyCommentAlertCellViewModel)
    
    var id: String {
        switch self {
        case .userFollow: return "userFollow"
        case .postComment: return "postComment"
        case .postCommentLike: return "postCommentLike"
        case .postCommentReply: return "postCommentReply"
        }
    }
}
