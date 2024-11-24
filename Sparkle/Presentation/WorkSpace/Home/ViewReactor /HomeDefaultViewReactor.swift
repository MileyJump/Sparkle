//
//  HomeDefaultViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 11/24/24.
//

import ReactorKit
import RxSwift

class HomeDefaultViewReactor: Reactor {
    
    enum Action {
        case addChannelsButtonTapped
    }
    
    enum Mutation {
        case createWorkspaceView
    }
    
    struct State {
        var createWorkspace: Bool = false
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(createWorkspace: false)
            
    }
    
    func mutate(action: Action) -> Observable<Mutation> {

        switch action {
        case .addChannelsButtonTapped:
            return Observable.just(.createWorkspaceView)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .createWorkspaceView:
            newState.createWorkspace = true
        }
        return newState
    }
}
