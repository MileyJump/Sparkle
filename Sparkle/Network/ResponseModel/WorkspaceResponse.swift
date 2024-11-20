//
//  WorkspaceResponse.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation

struct WorkspaceListCheckResponse: Decodable {
    let workspace_id: String
    let name: String
    let description: String
    let coverImage: String
    let owner_id: String
    let createdAt: String
}

struct CreateWorkspaceResponse: Decodable {
    
}
struct WorkspaceInformationCheckResponse: Decodable {
}

struct WorkspaceEditResponse: Decodable {
}

struct WorkspaceDeleteResponse: Decodable {
    
}
struct WorkspaceMembersInviteResponse: Decodable {
    
}

struct WorkspaceMemberCheckResponse: Decodable {
    
}
struct WorkspaceSpecificMemberCheckResponse: Decodable {
    
}
struct WorkspaceSearchResponse: Decodable {
    
}
struct ChangeWorkspaceManagerResponse: Decodable {
    
}
struct ExitWorkspaceResponse: Decodable {
}
