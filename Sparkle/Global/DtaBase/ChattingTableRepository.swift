//
//  ChattingTableRepository.swift
//  Sparkle
//
//  Created by 최민경 on 12/7/24.
//

import Foundation

import Foundation
import RealmSwift

class ChattingTableRepository {
    private let realm = try! Realm()
    
    // Realm에서 정렬된 항목을 가져오기 -> 오름차순(오래된 채팅부터)
    func fetchChattingList(sortedBy keypath: String = "chatCreateAt", ascending: Bool = true) -> [ChatTable] {
        let value = realm.objects(ChatTable.self).sorted(byKeyPath: keypath, ascending: ascending)
        return Array(value)
    }
    
    func createChatItem(chatItem: ChatTable) {
        do {
            try realm.write {
                realm.add(chatItem)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm append Error")
        }
    }
    
    func deleteAllData() {
        do {
            try realm.write {
                realm.deleteAll()
                print("All Realm data deleted.")
            }
        } catch {
            print("Realm Error: \(error)")
        }
    }
    
}
