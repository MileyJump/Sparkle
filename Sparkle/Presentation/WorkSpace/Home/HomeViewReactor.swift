//
//  HomeViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 11/8/24.
//

import ReactorKit
import RxSwift
import RxCocoa

final class HomeViewReactor: Reactor {
    
    enum Action {
        case xmark
        case createWorkspace
    }
    
    enum Mutation {
        case createWorkspaceToNextScreen
    }
    
    struct State {
        var shouldNavigateToNextScreen: Bool = false
    }
    
    let initialState: State
    
    // 처음 상태를 작성하기 위해서 사용
    init() {
        self.initialState = State(shouldNavigateToNextScreen: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .xmark:
            return Observable.just(.createWorkspaceToNextScreen) // 임시
        case .createWorkspace:
            return Observable.just(.createWorkspaceToNextScreen)
        
        }
    }
   
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .createWorkspaceToNextScreen:
            state.shouldNavigateToNextScreen = true
        }
        return state
    }
}

