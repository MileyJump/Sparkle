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
    
    convenience init(channelId: String, channelName: String, chatContent: String, chatCreateAt: String, files: [String], user: UserTable) {
        self.init()
        self.channelId = channelId
        self.channelName = channelName
        self.chatContent = chatContent
        self.chatCreateAt = chatCreateAt
        self.files.append(objectsIn: files)
        self.user = user
    }
}

class UserTable: Object {
    
    @Persisted var userId: String
    @Persisted var email: String
    @Persisted var nickname: String
    @Persisted var profilImage: String
    
    convenience init(userId: String, email: String, nickname: String, profilImage: String) {
        self.init()
        self.userId = userId
        self.email = email
        self.nickname = nickname
        self.profilImage = profilImage
    }
}

