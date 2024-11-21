//
//  ChannelResponse.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation

struct ChannelMembers: Decodable {
    let user_id: String
    let email: String
    let nickname: String
    let profileImage: String
}

struct ChannelResponse: Decodable {
    let channel_id: String
    let name: String
    let description: String
    let coverImage: String
    let owner_id: String
    let createdAt: String
}


struct SpecificChannelCheckResponse: Decodable {
    let channel_id: String
    let name: String
    let description: String
    let coverImage: String
    let owner_id: String
    let createdAt: String
    let channelMembers: [ UserMemberResponse ]
}


struct ChannelChatHistoryListResponse: Decodable {
    let channel_id: String
    let channelName: String
    let chat_id: String
    let content: String
    let createdAt: String
    let files: [ String ]
    let user: UserMemberResponse
}


struct NumberOfUnreadChannelChatsResponse: Decodable {
    let channel_id: String
    let name: String
    let count: Int
}
