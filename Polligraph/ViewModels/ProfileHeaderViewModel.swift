//
//  ProfileHeaderViewModel.swift
//  Polligraph
//
//  Created by Roy Park on 3/27/21.
//

import Foundation

enum ProfileButtonType {
    case edit
    case follow(isFollowing: Bool)
}

struct ProfileHeaderViewModel {
    let profileImageURL: URL?
    let followerCount: Int
    let pollsCount: Int
    let buttonType: ProfileButtonType
    let bio: String?
    let username: String
    let name: String?
}


