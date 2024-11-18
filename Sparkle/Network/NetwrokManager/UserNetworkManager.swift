//
//  UserNetworkManager.swift
//  Sparkle
//
//  Created by 최민경 on 11/18/24.
//

import Foundation
import Moya


extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    var RoutBaseURL: String {
        return BaseURL.baseURL + "v1"
    }
    
    var path: String {
        switch self {
        case .join:
            return ""
        case .emailValidation:
            return ""
        case .login:
            return ""
        case .kakaoLogin:
            return ""
        case .appleLogin:
            return ""
        case .logout:
            return ""
        case .deviceToken:
            return ""
        case .profileCheck:
            return ""
        case .profileModification:
            return ""
        case .profileImageModification:
            return ""
        case .userProfileCheck:
            return ""
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
    
    var headers: [String : String]? {
        return [Header.sesacKey.rawValue : key.key,
                Header.contentType.rawValue : Header.json.rawValue,
                Header.authorization.rawValue : UserDefaultsManager.shared.token
        ]
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
