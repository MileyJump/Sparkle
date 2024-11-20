//
//  ChannelAPI.swift
//  Sparkle
//
//  Created by 최민경 on 11/16/24.
//

import Foundation

enum ChannelAPI {
    case mychannelCheck(parameters: WorkspaceIDParameter, worskpaceID: String)
    
    case channelListCheck(parameters: WorkspaceIDParameter, worskpaceID: String)
    
    case createChannel(query: ChannelsQuery, parameters: WorkspaceIDParameter, worskpaceID: String)
    
    case specificChannelCheck(parameters: ChannelParameter, worskpaceID: String, channleID: String)
    
    case channelsEdit(query: ChannelsQuery ,Parameters: ChannelParameter, worskpaceID: String, channleID: String)
    
    case channelsDelete(parameters: ChannelParameter, worskpaceID: String, channleID: String)
    
    case channelChatHistoryList(parameters: ChannelChatHistoryListParameter, worskpaceID: String, channleID: String)
    
    case sendChannelChat(query: SendChannelChatQuery, parameters: ChannelParameter, worskpaceID: String, channleID: String)
    
    case numberOfUnreadChannelChats(parameters: NumberOfUnreadChannelChatsParameter, worskpaceID: String, channleID: String)
    
    case channelMembersCheck(parameters: ChannelParameter, worskpaceID: String, channleID: String)
    
    case changeChannelManager(query: ChangeChannelManagerQuery, parameters: ChannelParameter, worskpaceID: String, channleID: String)
    
    case leaveChannel(parameters: ChannelParameter , worskpaceID: String, channleID: String)
}
