//
//  DMSQuery.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation

struct CreateDMS: Encodable {
    let opponent_id: String
}

struct DMParamter: Encodable {
    let roomID: String
    let workspaceID: String
}

// multipart/form
struct SendDMChat: Encodable {
    let content: String
    let files: [String]
}

struct DMChatListCheckParameter: Encodable {
    let roomID: String
    let workspaceID: String
    let cursor_date: String
}

struct NumberOfUnreadDMs: Encodable {
    let roomID: String
    let workspaceID: String
    let after: String
}
