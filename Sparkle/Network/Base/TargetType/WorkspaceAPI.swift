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
    case workspaceInformationCheck(parameters: WorkspaceIDParameter, wokrpsaceID: String)
    case workspaceEdit(parameters: WorkspaceIDParameter, query: WorkspaceEditQury , wokrpsaceID: String)
    case workspaceDelete(parameters: WorkspaceIDParameter, wokrpsaceID: String)
    case workspaceMembersInvite(parameters: WorkspaceIDParameter, query: WorkspaceMembersInviteQuery, wokrpsaceID: String)
    case workspaceMemberCheck(parameters: WorkspaceIDParameter, wokrpsaceID: String)
    case workspaceSpecificMemberCheck(parameters: workspaceSpecificMemberCheckParameter, wokrpsaceID: String, userID: String)
    case workspaceSearch(parameters: workspaceSearchParameter, wokrpsaceID: String)
    case changeWorkspaceManager(parameters: WorkspaceIDParameter, query: ChangeWorkspaceAdministratorQuery, wokrpsaceID: String)
    case exitWorkspace(parameters: WorkspaceIDParameter, wokrpsaceID: String)
}
