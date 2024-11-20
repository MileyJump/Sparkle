//
//  WorkspaceManager.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation
import Moya
import RxSwift

final class WorkspaceNetworkManager {
    
    static let shared = WorkspaceNetworkManager()
    private let workspaceProvider: MoyaProvider<WorkspaceAPI>
    
    private init() {
        self.workspaceProvider = MoyaProvider<WorkspaceAPI>(plugins: [NetworkLoggerPlugin()])
    }
    
    //    func workspacesListCheck
    
    func createWorkspace(query: CreateWorkspaceQuery) -> Single<CreateWorkspaceResponse> {
        return Single.create { [weak self] single in
            self?.workspaceProvider.request(.createWorkspace(query: query)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodeData = try JSONDecoder().decode(CreateWorkspaceResponse.self, from: response.data)
                        single(.success(decodeData))
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
    
    func workspaceInformationCheck(parameters: WorkspaceIDParameter, workspaceID: String) -> Single<WorkspaceInformationCheckResponse> {
        return Single.create { [weak self] single in
            self?.workspaceProvider.request(.workspaceInformationCheck(parameters: parameters, workspaceID: workspaceID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodeData = try JSONDecoder().decode(WorkspaceInformationCheckResponse.self, from: response.data)
                        single(.success(decodeData))
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
    
    
    func workspaceEdit(parameters: WorkspaceIDParameter, query: WorkspaceEditQury , workspaceID: String) -> Single<WorkspaceEditResponse> {
        return Single.create { [weak self] single in
            self?.workspaceProvider.request(.workspaceEdit(parameters: parameters, query: query, workspaceID: workspaceID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodeData = try JSONDecoder().decode(WorkspaceEditResponse.self, from: response.data)
                        single(.success(decodeData))
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
    
    func workspaceDelete(parameters: WorkspaceIDParameter, workspaceID: String) -> Single<WorkspaceDeleteResponse> {
        return Single.create { [weak self] single in
            self?.workspaceProvider.request(.workspaceDelete(parameters: parameters, workspaceID: workspaceID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodeData = try JSONDecoder().decode(WorkspaceDeleteResponse.self, from: response.data)
                        single(.success(decodeData))
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
    
    
    func workspaceMembersInvite(parameters: WorkspaceIDParameter, query: WorkspaceMembersInviteQuery, workspaceID: String) -> Single<WorkspaceMembersInviteResponse> {
        return Single.create { [weak self] single in
            self?.workspaceProvider.request( .workspaceMembersInvite(parameters: parameters, query: query, workspaceID: workspaceID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(WorkspaceMembersInviteResponse.self, from: response.data)
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
    
    
    func workspaceMemberCheck(parameters: WorkspaceIDParameter, wokrpsaceID: String) -> Single<WorkspaceMemberCheckResponse> {
        return Single.create { [weak self] single in
            self?.workspaceProvider.request( .workspaceMemberCheck(parameters: parameters, workspaceID: wokrpsaceID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(WorkspaceMemberCheckResponse.self, from: response.data)
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
    
    func workspaceSpecificMemberCheck(parameters: workspaceSpecificMemberCheckParameter, wokrpsaceID: String, userID: String) -> Single<WorkspaceSpecificMemberCheckResponse> {
        return Single.create { [weak self] single in
            self?.workspaceProvider.request( .workspaceSpecificMemberCheck(parameters: parameters, workspaceID: wokrpsaceID, userID: userID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(WorkspaceSpecificMemberCheckResponse.self, from: response.data)
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
    
    func workspaceSearch(parameters: workspaceSearchParameter, workspaceID: String) -> Single<WorkspaceSearchResponse> {
        return Single.create { [weak self] single in
            self?.workspaceProvider.request(.workspaceSearch(parameters: parameters, workspaceID: workspaceID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(WorkspaceSearchResponse.self, from: response.data)
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
    
    func changeWorkspaceManager(parameters: WorkspaceIDParameter, query: ChangeWorkspaceAdministratorQuery, workspaceID: String) -> Single<ChangeWorkspaceManagerResponse> {
        return Single.create { [weak self] single in
            self?.workspaceProvider.request(.changeWorkspaceManager(parameters: parameters, query: query, workspaceID: workspaceID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(ChangeWorkspaceManagerResponse.self, from: response.data)
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
    
    func exitWorkspace(parameters: WorkspaceIDParameter, workspaceID: String) -> Single<ExitWorkspaceResponse> {
        return Single.create { [weak self] single in
            self?.workspaceProvider.request(.exitWorkspace(parameters: parameters, workspaceID: workspaceID)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoderData = try JSONDecoder().decode(ExitWorkspaceResponse.self, from: response.data)
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
