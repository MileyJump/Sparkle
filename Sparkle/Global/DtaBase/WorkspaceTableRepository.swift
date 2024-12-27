//
//  WorkspaceTableRepository.swift
//  Sparkle
//
//  Created by 최민경 on 12/16/24.
//


import Foundation
import RealmSwift

class WorkspaceTableRepository {
    private let realm = try! Realm()
    
    
    func fetchWorksaceID() -> String? {
        let value = realm.objects(WorkspaceIDTable.self).first?.workspaceID
        return value
    }

    func updateWorkspaceID(newWorkspaceID: String) {
        do {
            if let workspaceItem = realm.objects(WorkspaceIDTable.self).first {
                try realm.write {
                    workspaceItem.workspaceID = newWorkspaceID  // 새 값으로 업데이트
                }
                print("Workspace ID updated successfully to: \(newWorkspaceID)")
            } else {
                print("No WorkspaceIDTable entry found to update")
            }
        } catch {
            print("Error updating WorkspaceID: \(error)")
        }
    }
    
    func deleteAllWorkspaceIDs() {
        do {
            let allWorkspaces = realm.objects(WorkspaceIDTable.self)
            try realm.write {
                realm.delete(allWorkspaces)  // 모든 WorkspaceIDTable 객체 삭제
            }
            print("All Workspace IDs deleted successfully.")
        } catch {
            print("Error deleting all Workspace IDs: \(error)")
        }
    }
    
    func createWorkspaceID(id: WorkspaceIDTable) {
        do {
            try realm.write {
                realm.add(id)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm append Error")
        }
    }
}
