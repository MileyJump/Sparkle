//
//  UserResponse.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation

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
    let profileImage: String
    let phone: String?
    let provider: String?
    let createdAt: String
    let sesacCoin: Int?
    let token: Token?
}
//
//struct LoginResponse: Decodable {
//    let email: String
//    let password: String
//    let deviceToken: String
//}
//
//struct AppleLoginResponse: Decodable {
//    let idToken: String
//    let nickname: String
//    let deviceToken: String
//}

//struct ProfileCheckResponse: Decodable {
//    let user_id: String
//    let email: String
//    let nickname: String
//    let profileImage: String
//    let phone: String?
//    let provider: String?
//    let sesacCoin: Int
//    let createdAt: String
//}
//
//struct ProfileModificationResponse: Decodable {
//    let user_id: String
//    let email: String
//    let nickname: String
//    let profileImage: String
//    let phone: String?
//    let provider: String?
//    let createdAt: String
//}
//struct ProfileImageModificationResponse: Decodable {
//    let user_id: String
//    let email: String
//    let nickname: String
//    let profileImage: String
//    let phone: String
//    let provider: String?
//    let createdAt: String
//}

//struct UserProfileCheckResponse: Decodable {
//    let user_id: String
//    let email: String
//    let nickname: String
//    let profileImage: String
//    }

