//
//  DMSAPI.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation

enum DMSAPI {
    case createDMs(query: CreateDMS, parameters: WorkspaceIDParameter, worskpaceID: String)
    
    case dmsListCheck(parameters: WorkspaceIDParameter, worskpaceID: String)
    
    case sendDMs(query: SendDMChat, parameters: DMParamter, worskpaceID: String, roomID: String)
    
    case dmsChatListCheck(parameters: DMChatListCheckParameter, worskpaceID: String, roomID: String)
    
    case numberOfUnreadDMs(parameters: NumberOfUnreadDMs, worskpaceID: String, roomID: String)
}


