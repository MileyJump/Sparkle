//
//  WorkspaceQuery.swift
//  Sparkle
//
//  Created by 최민경 on 11/19/24.
//

import Foundation

struct CreateWorkspaceQuery: Encodable {
    let name: String
    let description: String?
    let image: String
}
struct WorkspaceEditQury: Encodable {
    let name: String
    let description: String
    let image: String
}

struct WorkspaceMembersInviteQuery: Encodable {
    let email: String
}

struct ChangeWorkspaceAdministratorQuery: Encodable {
    let owner_id: String
}


struct WorkspaceIDParameter: Encodable {
    let workspaceID: String
}

struct workspaceSpecificMemberCheckParameter: Encodable {
    let workspaceID: String
    let userId: String
}

struct workspaceSearchParameter: Encodable {
    let workspaceID: String
    let keyword: String
}


