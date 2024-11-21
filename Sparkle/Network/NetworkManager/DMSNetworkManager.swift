//
//  DMSNetworkManager.swift
//  Sparkle
//
//  Created by 최민경 on 11/21/24.
//

import Foundation
import Moya
import RxSwift

final class DMSNetworkManager {
    
    static let shared = DMSNetworkManager()
    private let dmsProvider: MoyaProvider<DMSAPI>
    
    private init() {
        self.dmsProvider = MoyaProvider<DMSAPI>(plugins: [NetworkLoggerPlugin()])
    }
    
    func createDMs(query: CreateDMS, parameters: WorkspaceIDParameter, workspaceID: String) -> Single<DmsListCheckResponse> {
        return Single.create { [weak self] single in
            self?.dmsProvider.request(.createDMs(query: query, parameters: parameters, workspaceID: workspaceID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(DmsListCheckResponse.self, from: response.data)
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
    
    func dmsListCheck(parameters: WorkspaceIDParameter, workspaceID: String) -> Single<DmsListCheckResponse> {
        return Single.create { [weak self] single in
            self?.dmsProvider.request(.dmsListCheck(parameters: parameters, workspaceID: workspaceID    )) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(DmsListCheckResponse.self, from: response.data)
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
    
    func sendDMs(query: SendDMChat, parameters: DMParamter, workspaceID: String, roomID: String) -> Single<SendDMsResponse> {
        return Single.create { [weak self] single in
            self?.dmsProvider.request(.sendDMs(query: query, parameters: parameters, workspaceID: workspaceID, roomID: roomID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(SendDMsResponse.self, from: response.data)
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
    
    func dmsChatListCheck(parameters: DMChatListCheckParameter, workspaceID: String, roomID: String) -> Single<SendDMsResponse> {
        return Single.create { [weak self] single in
            self?.dmsProvider.request(.dmsChatListCheck(parameters: parameters, workspaceID: workspaceID, roomID: roomID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(SendDMsResponse.self, from: response.data)
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
    
    func numberOfUnreadDMs(parameters: NumberOfUnreadDMs, workspaceID: String, roomID: String) -> Single<NumberOfUnreadDMsResponse> {
        
        return Single.create { [weak self] single in
            self?.dmsProvider.request(.numberOfUnreadDMs(parameters: parameters, workspaceID: workspaceID, roomID: roomID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(NumberOfUnreadDMsResponse.self, from: response.data)
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
