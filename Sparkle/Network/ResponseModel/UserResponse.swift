//
//  UserResponse.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation

struct VoidResponse: Decodable {}

struct UserMemberResponse: Decodable {
    let user_id: String
    let email: String
    let nickname: String
    let profileImage: String
}

struct Token: Decodable {
    let accessToken: String
    let refreshToken: String
}

struct UserResponse: Decodable {
    let user_id: String
    let email: String
    let nickname: String
    let profileImage: String?
    let phone: String?
    let provider: String?
    let createdAt: String
    let sesacCoin: Int?
    let token: Token?
}
