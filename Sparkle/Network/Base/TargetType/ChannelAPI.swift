//
//  ChannelAPI.swift
//  Sparkle
//
//  Created by 최민경 on 11/16/24.
//

import Foundation

enum ChannelAPI {
    case myChannelCheck(parameters: WorkspaceIDParameter)
    
    case channelListCheck(parameters: WorkspaceIDParameter, workspaceID: String)
    
    case createChannel(query: ChannelsQuery, parameters: WorkspaceIDParameter, workspaceID: String)
    
    case specificChannelCheck(parameters: ChannelParameter)
    
    case channelsEdit(query: ChannelsQuery ,parameters: ChannelParameter, workspaceID: String, channleID: String)
    
    case channelsDelete(parameters: ChannelParameter, workspaceID: String, channleID: String)
    
    case channelChatHistoryList(parameters: ChannelChatHistoryListParameter, workspaceID: String, channleID: String)
    
    case sendChannelChat(query: SendChannelChatQuery, parameters: ChannelParameter)
    
    case numberOfUnreadChannelChats(parameters: NumberOfUnreadChannelChatsParameter)
    
    case channelMembersCheck(parameters: ChannelParameter)
    
    case changeChannelManager(query: ChangeChannelManagerQuery, parameters: ChannelParameter, workspaceID: String, channleID: String)
    
    case leaveChannel(parameters: ChannelParameter , workspaceID: String, channleID: String)
}
