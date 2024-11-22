//
//  JoinQuery.swift
//  Sparkle
//
//  Created by 최민경 on 11/18/24.
//

import Foundation

struct JoinQuery: Encodable {
    let email: String
    let password: String
    let nickname: String
    let phone: String
    let deviceToken: String
}

struct EmailValidationQuery: Encodable {
    let email: String
}

struct LoginQuery: Encodable {
    let email: String
    let password: String
    let deviceToken: String
}

struct KakaoLoginQuery: Encodable {
    let oatuhToken: String
    let deviceToken: String
}

struct AppleLoginQuery: Encodable {
    let idToken: String
    let nicname: String
    let deviceToken: String
}

struct DeviceTokenQuery: Encodable {
    let deviceToken: String
}

struct ProfileCheckQuery: Encodable {
    let user_id: String
    let email: String
    let nickname: String
    let profileImage: String
    let phone: String
    let provider: String
    let sesacCoin: Int
    let createAt: String
}

struct ProfileModificationQuery: Encodable {
    let nickname: String
    let phone: String
}

struct ProfileImageModificationQuery: Encodable {
    let image: String
}

struct UserprofileCheckQuery: Encodable {
    let userID: String
}
