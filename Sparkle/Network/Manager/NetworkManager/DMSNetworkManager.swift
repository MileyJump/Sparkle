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
    
    func request<T: Decodable>(_ target: DMSAPI, responseType: T.Type) -> Single<T> {
        return Single.create { [weak self] single in
            self?.dmsProvider.request(target) { result in
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
    
    func createDMs(query: CreateDMS, parameters: WorkspaceIDParameter) -> Single<DmsListCheckResponse> {
        return request(.createDMs(query: query, parameters: parameters), responseType: DmsListCheckResponse.self)
    }
    
    func dmsListCheck(parameters: WorkspaceIDParameter) -> Single<[DmsListCheckResponse]> {
        return request(.dmsListCheck(parameters: parameters), responseType: [DmsListCheckResponse].self)
    }
    
    func sendDMs(query: SendDMChat, parameters: DMParamter, workspaceID: String, roomID: String) -> Single<SendDMsResponse> {
        return request(.sendDMs(query: query, parameters: parameters, workspaceID: workspaceID, roomID: roomID), responseType: SendDMsResponse.self)
    }
    
    func dmsChatListCheck(parameters: DMChatListCheckParameter, workspaceID: String, roomID: String) -> Single<SendDMsResponse> {
        return request(.dmsChatListCheck(parameters: parameters, workspaceID: workspaceID, roomID: roomID), responseType: SendDMsResponse.self)
    }
    
    func numberOfUnreadDMs(parameters: NumberOfUnreadDMs, workspaceID: String, roomID: String) -> Single<NumberOfUnreadDMsResponse> {
        return request(.numberOfUnreadDMs(parameters: parameters, workspaceID: workspaceID, roomID: roomID), responseType: NumberOfUnreadDMsResponse.self)
    }
}
