//
//  Workspace +.swift
//  Sparkle
//
//  Created by 최민경 on 11/19/24.
//

import Foundation
import Moya

extension WorkspaceAPI: BaseTarget {
    
    var headers: [String: String]? {
        
        if case .createWorkspace = self {
            return [
                Header.sesacKey.rawValue: SesacKey.key,
//                Header.contentType.rawValue: "multipart/form-data",
                Header.authorization.rawValue: UserDefaultsManager.shared.token
            ]
        } else {
            return [
                Header.sesacKey.rawValue: SesacKey.key,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.authorization.rawValue: UserDefaultsManager.shared.token
            ]
        }
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
        case .changeWorkspaceManager(_, _, let workspaceID):
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
        case .workspaceEdit, .changeWorkspaceManager:
            return .put
        case .workspaceDelete:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .workspacesListCheck:
            return .requestPlain

        case .createWorkspace(let query):
            var multipartData = [MultipartFormData]()
            
            if let nameData = query.name.data(using: .utf8) {
                multipartData.append(
                    MultipartFormData(provider: .data(nameData), name: "name")
                )
            }
            
            if let descriptionData = query.description?.data(using: .utf8) {
                multipartData.append(
                    MultipartFormData(provider: .data(descriptionData), name: "description")
                )
            }
            
             let imageData = query.image
                multipartData.append(
                    MultipartFormData(
                        provider: .data(imageData),
                        name: "image",
                        fileName: "workspace.jpeg",
                        mimeType: "image/jpeg"
                    )
                )
            
            return .uploadMultipart(multipartData)
        
        
        case .workspaceInformationCheck(let parameters, _):
            return .requestParameters(
                parameters: try! parameters.toDictionary(),
                encoding: URLEncoding.queryString
            )
            
        case .workspaceEdit(let parameters, let query, _):
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! parameters.toDictionary()
            )
        case .workspaceMembersInvite(let parameters, let query, _):
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! parameters.toDictionary()
            )
        case .changeWorkspaceManager(let parameters, let query, _):
            return .requestCompositeParameters(
                bodyParameters: try! query.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! parameters.toDictionary()
            )
       
        case .workspaceDelete(let parameters, _):
            return .requestParameters(
                parameters: try! parameters.toDictionary(),
                encoding: URLEncoding.queryString
            )
            
        case .workspaceMemberCheck(let parameters, _):
            return .requestParameters(
                parameters: try! parameters.toDictionary(),
                encoding: URLEncoding.queryString
            )
            
        case .workspaceSpecificMemberCheck(let parameters ,_ ,_):
            return .requestParameters(
                parameters: try! parameters.toDictionary(),
                encoding: URLEncoding.queryString
            )
        case .workspaceSearch(let parameters, _):
            return .requestParameters(
                parameters: try! parameters.toDictionary(),
                encoding: URLEncoding.queryString
            )
        case .exitWorkspace(let parameters, _):
            return .requestParameters(
                parameters: try! parameters.toDictionary(),
                encoding: URLEncoding.queryString
            )
        }
    }
}

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dictionary ?? [:]
    }
}

//extension WorkspaceAPI: BaseTarget {
//    var headers: [String : String]? {
//        switch self {
//        case .createWorkspace :
//            return [
//                Header.sesacKey.rawValue: SesacKey.key,
//                Header.authorization.rawValue: UserDefaultsManager.shared.token,
//                Header.contentType.rawValue: Header.multipart.rawValue
//            ]
//        default :
//            return [
//                Header.sesacKey.rawValue: SesacKey.key,
//                Header.contentType.rawValue: Header.json.rawValue,
//                Header.authorization.rawValue: UserDefaultsManager.shared.token
//            ]
//        }
//    }
//}
