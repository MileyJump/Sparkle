//
//  ChannelResponse.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation

struct MychannelCheckResponse: Decodable { }

struct ChannelListCheckResponse: Decodable { }

struct CreateChannelResponse: Decodable {}

struct SpecificChannelCheckResponse: Decodable { }
struct ChannelsEditResponse: Decodable { }
struct ChannelsDeleteResponse: Decodable { }
struct ChannelChatHistoryListResponse: Decodable { }

struct SendChannelChatResponse: Decodable { }

struct NumberOfUnreadChannelChatsResponse: Decodable { }

struct ChannelMembersCheckResponse: Decodable { }

struct ChangeChannelManagerResponse: Decodable { }

struct LeaveChannelResponse: Decodable { }
