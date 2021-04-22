//
//  Alert.swift
//  Polligraph
//
//  Created by Roy Park on 4/7/21.
//

import Foundation


public class Alert {
    var identifier = UUID().uuidString
    var isHidden = false
    let type: AlertCellType
    
    init(type: AlertCellType) {
        self.type = type
    }
    
    static func mockData() -> [Alert] {
        var alerts: [Alert] = []
        for _ in 0...4 {
            alerts.append(Alert(
                type: .userFollow(
                    viewModel:
                        FollowAlertCellViewModel(
                            username: "royparkHC",
                            profilePictureURL: nil,
                            isCurrentUserFollowing: false,
                            date: Date()
                        )
                )
            ))
            
            alerts.append(Alert(
                type: .postComment(
                    viewModel:
                        CommentAlertCellViewModel(
                            username: "royparkHC",
                            profilePictureURL: nil,
                            postURL: nil,
                            date: Date()
                        )
                )
            ))
            
            alerts.append(Alert(
                type: .postCommentLike(
                    viewModel:
                        LikeCommentAlertCellViewModel(
                            username: "royparkHC",
                            profilePictureURL: nil,
                            postURL: nil,
                            date: Date()
                        )
                )
            ))
            
            alerts.append(Alert(
                type: .postCommentReply(
                    viewModel:
                        ReplyCommentAlertCellViewModel(
                            username: "royparkHC",
                            profilePictureURL: nil,
                            postURL: nil,
                            date: Date()
                        )
                )
            ))
        }
        
        return alerts
    }
}
//    static func mockData() -> [Alert] {
//        let first = Array(0...5).compactMap({
//            Alert(text: "username started following you \($0)",
//                         type: .userFollow(username: "hard code username"),
//                         date: Date()
//            )
//        })
//
//        let second = Array(0...5).compactMap({
//            Alert(text: "username replied to your comment on title of the post: \($0)",
//                         type: .postComment(postName: "Post Name!"),
//                         date: Date()
//            )
//        })
//
//        let third = Array(0...5).compactMap({
//            Alert(text: "username liked your comment on title of the post \($0)",
//                         type: .postCommentLike(postName: "Comment Like"),
//                         date: Date()
//            )
//        })
//
//        return first + second + third
//
//    }
//    }
