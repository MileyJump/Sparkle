//
//  UserAPI.swift
//  Sparkle
//
//  Created by 최민경 on 11/14/24.
//

import Foundation

enum UserAPI {
    case join(JoinQuery)
    case emailValidation(EmailValidationQuery)
    case login(LoginQuery)
    case kakaoLogin(KakaoLoginQuery)
    case appleLogin(AppleLoginQuery)
    case logout
    case deviceToken(DeviceTokenQuery)
    case profileCheck(ProfileCheckQuery)
    case profileModification(ProfileModificationQuery)
    case profileImageModification
    case userProfileCheck(UserprofileCheckQuery)
}
