//
//  CreateWorkspaceViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 11/11/24.
//

import ReactorKit

import RxSwift
import RxCocoa

final class CreateWorkspaceViewReactor: Reactor {
    
    enum Action {
        case comfirmButton
    }
    
    enum Mutation {
        case comfirmButtonTapped
    }
    
    struct State {
        var comfirmButtonTapped: Bool = false
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(comfirmButtonTapped: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .comfirmButton:
            return Observable.just(.comfirmButtonTapped)
        }
    }
   
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .comfirmButtonTapped:
            state.comfirmButtonTapped = true
        }
        return state
    }
}


