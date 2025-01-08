//
//  WorkspaceListViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 12/16/24.
//
import UIKit

import ReactorKit
import RealmSwift

class WorkspaceListViewReactor: Reactor {
    
    enum Action {
        case fetchInitialChats
    }
    
    enum Mutation {
        case setWorkspaceList([WorkspaceListCheckResponse])
        case setError(Error)
    }
    
    struct State {
        var workspaceList: [WorkspaceListCheckResponse] = []
        var error: Error?
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchInitialChats:
            return workspaceListCheck()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setWorkspaceList(let list):
            newState.workspaceList = list
        case .setError(let error):
            newState.error = error
        }
        return newState
    }
    
    private func workspaceListCheck() -> Observable<Mutation> {
        WorkspaceNetworkManager.shared.workspacesListCheck()
            .asObservable()
            .flatMap { list in
                return Observable.just(Mutation.setWorkspaceList(list))
            }
            .catch { error in
                return Observable.just(.setError(error))
            }
    }
}
