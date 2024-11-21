//
//  WorkspaceResponse.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation

struct Channels: Decodable {
    let channel_id: String
    let name: String
    let description: String
    let coverImage: String
    let owner_id: String
    let createdAt: String
}
    


struct WorkspaceListCheckResponse: Decodable {
    let workspace_id: String
    let name: String
    let description: String
    let coverImage: String
    let owner_id: String
    let createdAt: String
}


struct WorkspaceInformationCheckResponse: Decodable {
    let workspace_id: String
    let name: String
    let description: String
    let coverImage: String
    let owner_id: String
    let createdAt: String
    let channels: [Channels]
    let workspaceMembers: [UserMemberResponse]
}


