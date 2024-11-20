//
//  ChannelQuery.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation


struct ChannelsQuery: Encodable {
    let name: String
    let description: String
    let image: String
}

// multipart/form-data
struct SendChannelChatQuery: Encodable {
    let content: String
    let files: [String]
}
struct ChangeChannelManagerQuery: Encodable {
    let owner_id: String
}




struct ChannelParameter: Encodable {
    let channelID: String
    let worskspaceID: String
}


struct ChannelChatHistoryListParameter: Encodable {
    let cursor_date: String?
    let channelID: String
    let workspaceId: String
}


struct NumberOfUnreadChannelChatsParameter: Encodable {
    let workspaceID: String
    let channelID: String
    let after: String?
}


