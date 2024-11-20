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
    case workspaceInformationCheck(parameters: WorkspaceIDParameter, workspaceID: String)
    case workspaceEdit(parameters: WorkspaceIDParameter, query: WorkspaceEditQury , workspaceID: String)
    case workspaceDelete(parameters: WorkspaceIDParameter, workspaceID: String)
    case workspaceMembersInvite(parameters: WorkspaceIDParameter, query: WorkspaceMembersInviteQuery, workspaceID: String)
    case workspaceMemberCheck(parameters: WorkspaceIDParameter, workspaceID: String)
    case workspaceSpecificMemberCheck(parameters: workspaceSpecificMemberCheckParameter, workspaceID: String, userID: String)
    case workspaceSearch(parameters: workspaceSearchParameter, workspaceID: String)
    case changeWorkspaceManager(parameters: WorkspaceIDParameter, query: ChangeWorkspaceAdministratorQuery, workspaceID: String)
    case exitWorkspace(parameters: WorkspaceIDParameter, workspaceID: String)
}
