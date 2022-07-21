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
