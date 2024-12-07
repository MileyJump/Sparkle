//
//  ChattingTable.swift
//  Sparkle
//
//  Created by 최민경 on 12/7/24.
//

import Foundation
import RealmSwift

class ChatTable: Object {
    
    @Persisted(primaryKey: true) var chatId: String
    @Persisted var channelId: String
    @Persisted var channelName: String
    @Persisted var chatContent: String
    @Persisted var chatCreateAt: String
    @Persisted var files = List<String>()
    @Persisted var user: UserTable
}

class UserTable: Object {
    
    @Persisted var userId: String
    @Persisted var email: String
    @Persisted var nickname: String
    @Persisted var profilImage: String
    
    
}

