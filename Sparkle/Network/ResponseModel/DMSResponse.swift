//
//  DMSResponse.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation

struct CreateDMsResponse: Decodable {
    let opponent_id: String
}

struct DmsListCheckResponse: Decodable  {
    let room_id: String
    let createdAt: String
    let user: UserMemberResponse
}

struct SendDMsResponse: Decodable {
    let dm_id: String
    let room_id: String
    let content: String
    let createdAt: String
    let files: [ String ]
    let user: UserMemberResponse
}

struct NumberOfUnreadDMsResponse: Decodable {
    let room_id: String
    let count: Int
}



