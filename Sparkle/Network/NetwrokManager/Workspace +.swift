//
//  Workspace +.swift
//  Sparkle
//
//  Created by 최민경 on 11/19/24.
//

import Foundation
import Moya

extension WorkspaceAPI: TargetType {
    var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    var RoutBaseURL: String {
        return BaseURL.baseURL + "v1/"
    }
    
    var path: String {
        switch self {
        case .workspacesListCheck, .createWorkspace:
            return "workspaces"
        case .workspaceInformationCheck(_, let query), .workspaceEdit(_, _, let query), .workspaceDelete(_, let query):
            return "workspaces/\(query)"
        case .workspaceMembersInvite(_, _, let query):
            return "workspaces/\(query)/members"
        case .workspaceMemberCheck(_, let queryt):
            return "workspaces/\(queryt)/members"
        case .workspaceSpecificMemberCheck(_, let workspaceID, let userID):
            return "workspaces/\(workspaceID)/members/\(userID)"
        case .workspaceSearch(_, let workspaceID):
            return "workspaces/\(workspaceID)/search"
        case .changeWorkspaceAdministrator(_, _, let workspaceID):
            return "workspaces/\(workspaceID)/transfer/ownership"
        case .exitWorkspace(_, let workspaceID):
            return "workspaces/\(workspaceID)/exit"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .workspacesListCheck, .workspaceInformationCheck, .workspaceMemberCheck, .workspaceSpecificMemberCheck, .workspaceSearch, .exitWorkspace:
            return .get
        case .createWorkspace, .workspaceMembersInvite:
            return .post
        case .workspaceEdit, .changeWorkspaceAdministrator:
            return .put
        case .workspaceDelete:
            return .delete
        }
    }
    
    var headers: [String : String]? {
        return [Header.sesacKey.rawValue : key.key,
                Header.contentType.rawValue : Header.json.rawValue,
                Header.authorization.rawValue : UserDefaultsManager.shared.token
        ]
    }
    
    var task: Task {
        switch self {
        case .workspacesListCheck:
            return .requestPlain
            
        case .createWorkspace(let query):
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: [:]
            )
            
        case .workspaceEdit(let parameters, let query, _):
            // Body와 URL Parameters를 함께 보내는 경우
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! parameters.toDictionary() // URL Parameters로 전달
            )
        case .workspaceMembersInvite(let parameters, let query, _):
            // Body와 URL Parameters를 함께 보내는 경우
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! parameters.toDictionary()
            )
        case .changeWorkspaceAdministrator(let parameters, let query, _):
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! parameters.toDictionary()
            )
        case .workspaceInformationCheck(let parameters, _):
            // URL에 파라미터만 추가해서 보냄
            return .requestParameters(
                parameters: try! parameters.toDictionary(),
                encoding: URLEncoding.queryString // URL 뒤에 ?key=value 형식으로 추가
            )
        case .workspaceDelete(let parameters, _):
            // URL에 파라미터만 추가해서 보냄
            return .requestParameters(
                parameters: try! parameters.toDictionary(),
                encoding: URLEncoding.queryString // URL 뒤에 ?key=value 형식으로 추가
            )
            
        case .workspaceMemberCheck(let parameters, _):
            return .requestParameters(
                parameters: try! parameters.toDictionary(),
                encoding: URLEncoding.queryString // URL 뒤에 ?key=value 형식으로 추가
            )
            
        case .workspaceSpecificMemberCheck(let parameters ,_ ,_):
            return .requestParameters(
                parameters: try! parameters.toDictionary(),
                encoding: URLEncoding.queryString // URL 뒤에 ?key=value 형식으로 추가
            )
        case .workspaceSearch(let parameters, _):
            // URL에 파라미터만 추가해서 보냄
            return .requestParameters(
                parameters: try! parameters.toDictionary(),
                encoding: URLEncoding.queryString
            )
        case .exitWorkspace(let parameters, _):
            // URL에 파라미터만 추가해서 보냄
            return .requestParameters(
                parameters: try! parameters.toDictionary(),
                encoding: URLEncoding.queryString // URL 뒤에 ?key=value 형식으로 추가
            )
            
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dictionary ?? [:]
    }
}
