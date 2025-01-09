//
//  ChannelsNetworkManager.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation
import Moya
import RxSwift

final class ChannelsNetworkManager {
    
    static let shared = ChannelsNetworkManager()
    private let channelProvider: MoyaProvider<ChannelAPI>
    
    private init() {
        self.channelProvider = MoyaProvider<ChannelAPI>(plugins: [NetworkLoggerPlugin()])
    }
    
    func request<T: Decodable>(_ target: ChannelAPI, responseType: T.Type) -> Single<T> {
        return Single.create { [weak self] single in
            self?.channelProvider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        if T.self == VoidResponse.self {
                            single(.success(VoidResponse() as! T))
                        } else {
                            let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                            single(.success(decodedData))
                        }
                    } catch {
                        single(.failure(error))
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func myChannelCheck(parameters: WorkspaceIDParameter) -> Single<[ChannelResponse]> {
        return request(.myChannelCheck(parameters: parameters), responseType: [ChannelResponse].self)
    }
    
    func channelListCheck(parameters: WorkspaceIDParameter, workspaceID: String) -> Single<[ChannelResponse]> {
        return request(.channelListCheck(parameters: parameters, workspaceID: workspaceID), responseType: [ChannelResponse].self)
    }
    
    func createChannel(query: ChannelsQuery, parameters: WorkspaceIDParameter, workspaceID: String) -> Single<ChannelResponse> {
        return request(.createChannel(query: query, parameters: parameters, workspaceID: workspaceID), responseType: ChannelResponse.self)
    }
    
    func specificChannelCheck(parameters: ChannelParameter) -> Single<SpecificChannelCheckResponse> {
        return request(.specificChannelCheck(parameters: parameters), responseType: SpecificChannelCheckResponse.self)
    }
    
    func channelsEdit(query: ChannelsQuery ,parameters: ChannelParameter, workspaceID: String, channleID: String) -> Single<ChannelResponse> {
        return request(.channelsEdit(query: query, parameters: parameters, workspaceID: workspaceID, channleID: channleID), responseType: ChannelResponse.self)
    }
    
    func channelsDelete(parameters: ChannelParameter, workspaceID: String, channleID: String)  -> Single<Void> {
        return request(.channelsDelete(parameters: parameters, workspaceID: workspaceID, channleID: channleID), responseType: VoidResponse.self).map { _ in }
    }
    
    func channelChatHistoryList(parameters: ChannelChatHistoryListParameter)  -> Single<[ChannelChatHistoryListResponse]> {
        return request(.channelChatHistoryList(parameters: parameters, workspaceID: parameters.workspaceId, channleID: parameters.channelID), responseType: [ChannelChatHistoryListResponse].self)
    }
    
    func sendChannelChat(query: SendChannelChatQuery, parameters: ChannelParameter) -> Single<ChannelChatHistoryListResponse> {
        return request(.sendChannelChat(query: query, parameters: parameters), responseType: ChannelChatHistoryListResponse.self)
    }
    
    func numberOfUnreadChannelChats(parameters: NumberOfUnreadChannelChatsParameter) -> Single<NumberOfUnreadChannelChatsResponse> {
        return request(.numberOfUnreadChannelChats(parameters: parameters), responseType: NumberOfUnreadChannelChatsResponse.self)
    }
    
    func channelMembersCheck(parameters: ChannelParameter) -> Single<[UserMemberResponse]> {
        return request(.channelMembersCheck(parameters: parameters), responseType: [UserMemberResponse].self)
    }
    
    func changeChannelManager(query: ChangeChannelManagerQuery, parameters: ChannelParameter, workspaceID: String, channleID: String) -> Single<ChannelResponse> {
        return request(.changeChannelManager(query: query, parameters: parameters, workspaceID: workspaceID, channleID: channleID), responseType: ChannelResponse.self)
    }
    
    func leaveChannel(parameters: ChannelParameter , workspaceID: String, channleID: String) -> Single<ChannelResponse> {
        return request(.leaveChannel(parameters: parameters, workspaceID: workspaceID, channleID: channleID), responseType: ChannelResponse.self)
    }
}
