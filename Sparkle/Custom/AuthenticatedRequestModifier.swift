//
//  AuthenticatedRequestModifier.swift
//  Sparkle
//
//  Created by 최민경 on 12/28/24.
//

import Kingfisher
import Foundation

struct AuthenticatedRequestModifier: ImageDownloadRequestModifier {
    
    func modified(for request: URLRequest) -> URLRequest? {
        var modifiedRequest = request
        modifiedRequest.addValue(SesacKey.key, forHTTPHeaderField: Header.sesacKey.rawValue ) // 헤더에 API 키 추가
        
        return modifiedRequest
    }
}
