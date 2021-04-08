//
//  Notification.swift
//  Polligraph
//
//  Created by Roy Park on 4/7/21.
//

import Foundation


enum NotificationType {
    case userFollow(username: String)
    case postComment(postName: String)
    case postCommentLike(postName: String)
    
    var id: String {
        switch self {
        case .userFollow: return "userFollow"
        case .postComment: return "postComment"
        case .postCommentLike: return "postCommentLike"
        }
    }
}

public class Notification {
    var identifier = UUID().uuidString
    var isHidden = false
    let text: String
    let type: NotificationType
    let date: Date
    
    init(text: String, type: NotificationType, date: Date) {
        self.text = text
        self.type = type
        self.date = date
    }
    
    static func mockData() -> [Notification] {
        let first = Array(0...5).compactMap({
            Notification(text: "Notification: \($0)",
                         type: .userFollow(username: "hard code username"),
                         date: Date()
            )
        })
        
        let second = Array(0...5).compactMap({
            Notification(text: "Notification: \($0)",
                         type: .postComment(postName: "Post Name!"),
                         date: Date()
            )
        })
        
        let third = Array(0...5).compactMap({
            Notification(text: "Notification: \($0)",
                         type: .postCommentLike(postName: "Comment Like"),
                         date: Date()
            )
        })
        
        return first + second + third
        
    }
}
