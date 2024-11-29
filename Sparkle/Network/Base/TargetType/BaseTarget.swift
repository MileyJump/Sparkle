//
//  BaseTarget.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//


import Foundation
import Moya

protocol BaseTarget: TargetType {}

extension BaseTarget {
    var baseURL: URL {
        return URL(string: "\(BaseURL.baseURL)v1/")!
    }
    
    var headers: [String: String]? {
        
        return [
            Header.sesacKey.rawValue: SesacKey.key,
            Header.contentType.rawValue: Header.json.rawValue,
            Header.authorization.rawValue: UserDefaultsManager.shared.token
        ]
    }
}
