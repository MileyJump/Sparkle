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
    
    
    func myChannelCheck(parameters: WorkspaceIDParameter, workspaceID: String) -> Single<ChannelResponse> {
        return Single.create { [weak self] single in
            self?.channelProvider.request(.myChannelCheck(parameters: parameters, workspaceID: workspaceID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(ChannelResponse.self, from: response.data)
                        single(.success(decoderData))
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
    
    func channelListCheck(parameters: WorkspaceIDParameter, workspaceID: String) -> Single<ChannelResponse> {
        return Single.create { [weak self] single in
            self?.channelProvider.request(.channelListCheck(parameters: parameters, workspaceID: workspaceID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(ChannelResponse.self, from: response.data)
                        single(.success(decoderData))
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
    
    func createChannel(query: ChannelsQuery, parameters: WorkspaceIDParameter, workspaceID: String) -> Single<ChannelResponse> {
        return Single.create { [weak self] single in
            self?.channelProvider.request(.createChannel(query: query, parameters: parameters, workspaceID: workspaceID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(ChannelResponse.self, from: response.data)
                        single(.success(decoderData))
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
    
    func specificChannelCheck(parameters: ChannelParameter, workspaceID: String, channleID: String) -> Single<SpecificChannelCheckResponse> {
        return Single.create { [weak self] single in
            self?.channelProvider.request(.specificChannelCheck(parameters: parameters, workspaceID: workspaceID, channleID: channleID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(SpecificChannelCheckResponse.self, from: response.data)
                        single(.success(decoderData))
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
    
    func channelsEdit(query: ChannelsQuery ,parameters: ChannelParameter, workspaceID: String, channleID: String) -> Single<ChannelResponse> {
        return Single.create { [weak self] single in
            self?.channelProvider.request(.channelsEdit(query: query, parameters: parameters, workspaceID: workspaceID, channleID: channleID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(ChannelResponse.self, from: response.data)
                        single(.success(decoderData))
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
    
    func channelsDelete(parameters: ChannelParameter, workspaceID: String, channleID: String)  -> Single<Void> {
        return Single.create { [weak self] single in
            self?.channelProvider.request(.channelsDelete(parameters: parameters, workspaceID: workspaceID, channleID: channleID)) { result in
                switch result {
                case .success(let response):
                
                        single(.success(()))
                  
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    
    func channelChatHistoryList(parameters: ChannelChatHistoryListParameter, workspaceID: String, channleID: String)  -> Single<ChannelChatHistoryListResponse> {
        
        return Single.create { [weak self] single in
            self?.channelProvider.request(.channelChatHistoryList(parameters: parameters, workspaceID: workspaceID, channleID: channleID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(ChannelChatHistoryListResponse.self, from: response.data)
                        single(.success(decoderData))
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
    
    func sendChannelChat(query: SendChannelChatQuery, parameters: ChannelParameter, workspaceID: String, channleID: String) -> Single<ChannelChatHistoryListResponse> {
        return Single.create { [weak self] single in
            self?.channelProvider.request(.sendChannelChat(query: query, parameters: parameters, workspaceID: workspaceID, channleID: channleID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(ChannelChatHistoryListResponse.self, from: response.data)
                        single(.success(decoderData))
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
    
    func numberOfUnreadChannelChats(parameters: NumberOfUnreadChannelChatsParameter, workspaceID: String, channleID: String) -> Single<NumberOfUnreadChannelChatsResponse> {
        return Single.create { [weak self] single in
            self?.channelProvider.request(.numberOfUnreadChannelChats(parameters: parameters, workspaceID: workspaceID, channleID: channleID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(NumberOfUnreadChannelChatsResponse.self, from: response.data)
                        single(.success(decoderData))
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
    
    func channelMembersCheck(parameters: ChannelParameter, workspaceID: String, channleID: String) -> Single<UserMemberResponse> {
        return Single.create { [weak self] single in
            self?.channelProvider.request(.channelMembersCheck(parameters: parameters, workspaceID: workspaceID, channleID: channleID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(UserMemberResponse.self, from: response.data)
                        single(.success(decoderData))
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
    
    func changeChannelManager(query: ChangeChannelManagerQuery, parameters: ChannelParameter, workspaceID: String, channleID: String) -> Single<ChannelResponse> {
        return Single.create { [weak self] single in
            self?.channelProvider.request(.changeChannelManager(query: query, parameters: parameters, workspaceID: workspaceID, channleID: channleID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(ChannelResponse.self, from: response.data)
                        single(.success(decoderData))
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
    
    func leaveChannel(parameters: ChannelParameter , workspaceID: String, channleID: String) -> Single<ChannelResponse> {
        return Single.create { [weak self] single in
            self?.channelProvider.request(.leaveChannel(parameters: parameters, workspaceID: workspaceID, channleID: channleID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(ChannelResponse.self, from: response.data)
                        single(.success(decoderData))
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
}
