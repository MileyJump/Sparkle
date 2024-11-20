//
//  MDS +.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation
import Moya

extension DMSAPI: BaseTarget {
    
    var path: String {
        switch self {
        case .createDMs(_, _, let worskpaceID):
            return "/v1/workspaces/\(worskpaceID)/dms"
        
        case .dmsListCheck(_, let worskpaceID):
            return "/v1/workspaces/\(worskpaceID)/dms"
            
        case .sendDMs(_, _, let worskpaceID, let roomID):
            return "/v1/workspaces/\(worskpaceID)/dms/\(roomID)/chats"
            
        case .dmsChatListCheck(_, let worskpaceID, let roomID):
            return "/v1/workspaces/\(worskpaceID)/dms/\(roomID)/chats"
            
        case .numberOfUnreadDMs(_, let worskpaceID, let roomID):
            return "/v1/workspaces/\(worskpaceID)/dms/\(roomID)/unreads"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createDMs, .sendDMs:
            return .post
        case .dmsListCheck, .dmsChatListCheck, .numberOfUnreadDMs:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .createDMs(let query, let parameters, _):
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! parameters.toDictionary()
            )
            
        case .dmsListCheck(let parameters, _):
            return .requestParameters(parameters: try! parameters.toDictionary(), encoding: URLEncoding.default)
            
        case .sendDMs(let query, let parameters, _, _):
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! parameters.toDictionary()
            )
            
        case .dmsChatListCheck(let parameters, _, _):
            return .requestParameters(parameters: try! parameters.toDictionary(), encoding: URLEncoding.default)
            
        case .numberOfUnreadDMs(let parameters, _, _):
            return .requestParameters(parameters: try! parameters.toDictionary(), encoding: URLEncoding.default)
        }
   
    }
}
