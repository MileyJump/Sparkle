//
//  WorkspaceAPI.swift
//  Sparkle
//
//  Created by 최민경 on 11/15/24.
//

import Foundation

enum WorkspaceAPI {
    case workspacesListCheck
    case createWorkspace(query: CreateWorkspaceQuery)
    case workspaceInformationCheck(parameters: workspaceIDParameter, wokrpsaceID: String)
    case workspaceEdit(parameters: workspaceIDParameter, query: WorkspaceEditQury , wokrpsaceID: String)
    case workspaceDelete(parameters: workspaceIDParameter, wokrpsaceID: String)
    case workspaceMembersInvite(parameters: workspaceIDParameter, query: WorkspaceMembersInviteQuery, wokrpsaceID: String)
    case workspaceMemberCheck(parameters: workspaceIDParameter, wokrpsaceID: String)
    case workspaceSpecificMemberCheck(parameters: workspaceSpecificMemberCheckParameter, wokrpsaceID: String, userID: String)
    case workspaceSearch(parameters: workspaceSearchParameter, wokrpsaceID: String)
    case changeWorkspaceAdministrator(parameters: workspaceIDParameter, query: ChangeWorkspaceAdministratorQuery, wokrpsaceID: String)
    case exitWorkspace(parameters: workspaceIDParameter, wokrpsaceID: String)
}
