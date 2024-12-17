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
    
    func request<T: Decodable>(_ target: WorkspaceAPI, responseType: T.Type) -> Single<T> {
        return Single.create { [weak self] single in
            self?.workspaceProvider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        // 상태 코드 로그
                        print("Status Code: \(response.statusCode)")
                        
                        if T.self == VoidResponse.self {
                            single(.success(VoidResponse() as! T))
                            print("Void Response")
                        } else {
                            let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                            single(.success(decodedData))
                        }
                    } catch {
                        // 디코딩 에러 시 상태 코드 및 응답 로그
                        print("Decoding error: \(error.localizedDescription)")
                        print("Status Code: \(response.statusCode)")
                        if let responseString = String(data: response.data, encoding: .utf8) {
                            print("Error Response Body: \(responseString)")
                            // 서버 응답 JSON에서 에러 코드 추출
                            if let errorInfo = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any],
                               let errorCode = errorInfo["code"] as? Int {
                                print("Server Error Code: \(errorCode)")
                            }
                        }
                        single(.failure(error))
                    }
                case .failure(let error):
                    if let moyaError = error as? MoyaError {
                        switch moyaError {
                        case .statusCode(let response):
                            print("========Error Status Code: \(response.statusCode)")
                            if let responseString = String(data: response.data, encoding: .utf8) {
                                print("==========Error Response Body: \(responseString)")
                                // 서버 응답 JSON에서 에러 코드 추출
                                if let errorInfo = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any],
                                   let errorCode = errorInfo["code"] as? Int {
                                    print("=======Server Error Code: \(errorCode)")
                                }
                            }
                        default:
                            break
                        }
                    }
                    print("========Network error: \(error.localizedDescription)")
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
//    func request<T: Decodable>(_ target: WorkspaceAPI, responseType: T.Type) -> Single<T> {
//        return Single.create { [weak self] single in
//            self?.workspaceProvider.request(target) { result in
//                switch result {
//                case .success(let response):
//                    do {
//                        if T.self == VoidResponse.self {
//                            single(.success(VoidResponse() as! T))
//                            print("Void")
//                        } else {
//                            let decodedData = try JSONDecoder().decode(T.self, from: response.data)
//                            single(.success(decodedData))
//                            print(response)
//                        }
//                    } catch {
//                        single(.failure(error))
//                        print(error)
//                    }
//                case .failure(let error):
//                    single(.failure(error))
//                    print(error)
//                }
//            }
//            return Disposables.create()
//        }
//    }
//    
    func workspacesListCheck() -> Single<[WorkspaceListCheckResponse]> {
        return request(.workspacesListCheck, responseType: [WorkspaceListCheckResponse].self)
    }
    
    func createWorkspace(query: CreateWorkspaceQuery) -> Single<WorkspaceListCheckResponse> {
    
        return request(.createWorkspace(query: query), responseType: WorkspaceListCheckResponse.self)
    }
    
    func workspaceInformationCheck(parameters: WorkspaceIDParameter, workspaceID: String) -> Single<WorkspaceInformationCheckResponse> {
        return request(.workspaceInformationCheck(parameters: parameters, workspaceID: workspaceID), responseType: WorkspaceInformationCheckResponse.self)
    }
    
    func workspaceEdit(parameters: WorkspaceIDParameter, query: WorkspaceEditQury , workspaceID: String) -> Single<WorkspaceListCheckResponse> {
        return request(.workspaceEdit(parameters: parameters, query: query, workspaceID: workspaceID), responseType: WorkspaceListCheckResponse.self)
    }
    
    func workspaceDelete(parameters: WorkspaceIDParameter, workspaceID: String) -> Single<Void> {
        return request(.workspaceDelete(parameters: parameters, workspaceID: workspaceID), responseType: VoidResponse.self).map { _ in }
    }
    
    func workspaceMembersInvite(parameters: WorkspaceIDParameter, query: WorkspaceMembersInviteQuery, workspaceID: String) -> Single<UserMemberResponse> {
        return request(.workspaceMembersInvite(parameters: parameters, query: query, workspaceID: workspaceID), responseType: UserMemberResponse.self)
    }
    
    
    func workspaceMemberCheck(parameters: WorkspaceIDParameter, workspaceID: String) -> Single<UserMemberResponse> {
        return request(.workspaceMemberCheck(parameters: parameters, workspaceID: workspaceID), responseType: UserMemberResponse.self)
    }
    
    func workspaceSpecificMemberCheck(parameters: workspaceSpecificMemberCheckParameter, workspaceID: String, userID: String) -> Single<UserMemberResponse> {
        return request(.workspaceSpecificMemberCheck(parameters: parameters, workspaceID: workspaceID, userID: userID), responseType: UserMemberResponse.self)
    }
    
    func workspaceSearch(parameters: workspaceSearchParameter, workspaceID: String) -> Single<WorkspaceInformationCheckResponse> {
        return request(.workspaceSearch(parameters: parameters, workspaceID: workspaceID), responseType: WorkspaceInformationCheckResponse.self)
    }
    
    func changeWorkspaceManager(parameters: WorkspaceIDParameter, query: ChangeWorkspaceAdministratorQuery, workspaceID: String) -> Single<WorkspaceListCheckResponse> {
            return request(.changeWorkspaceManager(parameters: parameters, query: query, workspaceID: workspaceID), responseType: WorkspaceListCheckResponse.self)
    }
    
    func exitWorkspace(parameters: WorkspaceIDParameter, workspaceID: String) -> Single<WorkspaceListCheckResponse> {
        return request(.exitWorkspace(parameters: parameters, workspaceID: workspaceID), responseType: WorkspaceListCheckResponse.self)
    }
}
