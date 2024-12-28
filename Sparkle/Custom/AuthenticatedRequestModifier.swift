//
//  AuthenticatedRequestModifier.swift
//  Sparkle
//
//  Created by 최민경 on 12/28/24.
//

import Kingfisher

struct AuthenticatedRequestModifier: ImageDownloadRequestModifier {
    let apiKey: String

    func modified(for request: URLRequest) -> URLRequest? {
        var modifiedRequest = request
        modifiedRequest.addValue(apiKey, forHTTPHeaderField: "Authorization") // 헤더에 API 키 추가
        return modifiedRequest
    }
}
