//
//  Channels +.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation
import Moya

extension ChannelAPI: BaseTarget {
    
    var path: String {
        switch self {
        case .myChannelCheck(let parameter):
            return "workspaces/\(parameter.workspaceID)/my-channels"
            
        case .channelListCheck(_, let workspaceID):
            return "/v1/workspaces/\(workspaceID)/channels"
            
        case .createChannel(_, _, let workspaceID):
            return "/v1/workspaces/\(workspaceID)/channels"
            
        case .specificChannelCheck(_, let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)"
            
        case .channelsEdit(_, _, let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)"
            
        case .channelsDelete(_, let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)"
            
        case .channelChatHistoryList(_, let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)/chats"
            
        case .sendChannelChat(_, _, let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)/chats"
            
        case .numberOfUnreadChannelChats(_, let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)/unreads"
            
        case .channelMembersCheck(_, let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)/members"
            
        case .changeChannelManager(_, _, let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)/transfer/ownership"
            
        case .leaveChannel(_, let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)/exit"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .myChannelCheck, .channelListCheck, .specificChannelCheck, .channelChatHistoryList, .numberOfUnreadChannelChats, .channelMembersCheck, .leaveChannel:
            return .get
        
        case .createChannel, .sendChannelChat:
            return .post
            
        case .channelsEdit, .changeChannelManager:
            return .put
            
        case .channelsDelete:
            return .delete
    
        }
    }
    
    var task: Task {
        switch self {
        case .myChannelCheck(let parameters):
            return .requestPlain
//            return .requestParameters(parameters: try! parameters.toDictionary(), encoding: URLEncoding.default)
            
        case .channelListCheck(let parameters, _):
            return .requestParameters(parameters: try! parameters.toDictionary(), encoding: URLEncoding.default)
            
        case .createChannel(let query, let parameters, _):
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! parameters.toDictionary()
            )
            
        case .specificChannelCheck(let parameters, _, _):
            return .requestParameters(parameters: try! parameters.toDictionary(), encoding: URLEncoding.default)
            
        case .channelsEdit(let query, let parameters, _, _):
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! parameters.toDictionary()
            )
            
        case .channelsDelete(let parameters, _, _):
            return .requestParameters(parameters: try! parameters.toDictionary(), encoding: URLEncoding.default)
            
        case .channelChatHistoryList(let parameters, _, _):
            return .requestParameters(parameters: try! parameters.toDictionary(), encoding: URLEncoding.default)
            
        case .sendChannelChat(let query, let parameters, _, _):
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! parameters.toDictionary()
            )
            
        case .numberOfUnreadChannelChats(let parameters, _, _):
            return .requestParameters(parameters: try! parameters.toDictionary(), encoding: URLEncoding.default)
            
        case .channelMembersCheck(let parameters, _, _):
            return .requestParameters(parameters: try! parameters.toDictionary(), encoding: URLEncoding.default)
            
        case .changeChannelManager(let query, let parameters, _, _):
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! parameters.toDictionary()
            )
            
        case .leaveChannel(let parameters, _, _):
            return .requestParameters(parameters: try! parameters.toDictionary(), encoding: URLEncoding.default)
        }
    }
}
