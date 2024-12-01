//
//  DMSAPI.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation

enum DMSAPI {
    case createDMs(query: CreateDMS, parameters: WorkspaceIDParameter)
    
    case dmsListCheck(parameters: WorkspaceIDParameter, workspaceID: String)
    
    case sendDMs(query: SendDMChat, parameters: DMParamter, workspaceID: String, roomID: String)
    
    case dmsChatListCheck(parameters: DMChatListCheckParameter, workspaceID: String, roomID: String)
    
    case numberOfUnreadDMs(parameters: NumberOfUnreadDMs, workspaceID: String, roomID: String)
}


