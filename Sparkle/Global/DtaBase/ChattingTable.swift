//
//  ChattingTable.swift
//  Sparkle
//
//  Created by 최민경 on 12/7/24.
//

import Foundation
import RealmSwift

class ChatTable: Object {
    @Persisted var channelId: String
    @Persisted var channelName: String
    @Persisted var chatId: String
    @Persisted var chatContent: String
    @Persisted var chatCreateAt: String
    
    
    
    
}

class ChattingTable: Object {
    
    @Persisted(primaryKey: true) var id: String // results에 있는 id
    @Persisted var userName: String
    @Persisted var dateAdded: Date = Date()
    @Persisted var createDate: String
    @Persisted var userProfileImage: String
    @Persisted var imageURL: String
    @Persisted var imageHeight: Int
    @Persisted var imageWidth: Int
   
    
    
    convenience init(id: String, userName: String, createDate: String, userProfileImage: String, imageURL: String, imageHeight: Int, imageWidth: Int) {
        self.init()
        self.id = id
        self.userName = userName
        self.createDate = createDate
        self.userProfileImage = userProfileImage
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        self.imageWidth = imageWidth
       
    }
}


[
  {
    "channel_id": "17029840-97ee-405e-bc82-1a3d047e3c2f",
    "channelName": "일반",
    "chat_id": "1355115a6-040a-4726-a6a3-d62944b72f68",
    "content": "안녕하세요.",
    "createdAt": "2023-12-21T22:47:30.236Z",
    "files": [
      "/static/channelChats/면접질문 정리_1701706651157.zip",
      "/static/channelChats/스크린샷 2000-02-03 오전 1.05.44_1701706651161.png",
      "/static/channelChats/SeSAC_1701706651166.gif"
    ],
    "user": {
      "user_id": "be4cd55a-359a-4e24-a4ef-5eb4423614dc",
      "email": "sesac@sesac.com",
      "nickname": "새싹",
      "profileImage": "/static/profiles/1701706651161.jpeg"
    }
  }
]

