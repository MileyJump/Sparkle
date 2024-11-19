//
//  UserNetworkManager.swift
//  Sparkle
//
//  Created by 최민경 on 11/18/24.
//

import Foundation
import Moya


extension UserAPI: BaseTarget {
    
    var path: String {
        switch self {
        case .join:
            return "users/join"
        case .emailValidation:
            return "users/validation/email"
        case .login:
            return "users/login"
        case .kakaoLogin:
            return "users/login/kakao"
        case .appleLogin:
            return "users/login/apple"
        case .logout:
            return "users/logout"
        case .deviceToken:
            return "users/deviceToken"
        case .profileCheck:
            return "users/me"
        case .profileModification:
            return "users/me"
        case .profileImageModification:
            return "users/me"
        case .userProfileCheck:
            return "users/{userID}"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .join, .emailValidation, .login, .kakaoLogin, .appleLogin, .deviceToken:
                .post
        case .logout, .profileCheck, .userProfileCheck:
                .get
        case .profileModification, .profileImageModification:
                .put
        }
    }
    
    var task: Task {
        switch self {
        case .join(let query):
            return encodeToTask(query)
        case .emailValidation(let query):
            return encodeToTask(query)
        case .login(let query):
            return encodeToTask(query)
        case .kakaoLogin(let query):
            return encodeToTask(query)
        case .appleLogin(let query):
            return encodeToTask(query)
        case .deviceToken(let query):
            return encodeToTask(query)
        case .profileCheck(let query):
            return encodeToTask(query)
        case .profileModification(let query):
            return encodeToTask(query)
        case .userProfileCheck(let query):
            return encodeToTask(query)
        case .logout, .profileImageModification:
            return .requestPlain
        }
    }
    
    private func encodeToTask<T: Encodable>(_ query: T) -> Task {
        do {
            let data = try JSONEncoder().encode(query)
            return .requestData(data)
        } catch {
            print("encode query 실패")
            return .requestPlain
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}
