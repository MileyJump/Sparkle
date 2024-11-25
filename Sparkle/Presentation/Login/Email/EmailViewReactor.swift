//
//  EmailViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 11/24/24.
//

import ReactorKit

import RxSwift
import RxCocoa

final class EmailLoginViewReactor: Reactor {
    
    enum Action {
        case comfirmButton
        case backButton
    }
    
    enum Mutation {
        case comfirmButtonTapped
        case backButtonTapped
    }
    
    struct State {
        var comfirmButtonTapped: Bool = false
        var backButtonTappedState: Bool = false
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(comfirmButtonTapped: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .comfirmButton:
            return Observable.just(.comfirmButtonTapped)
        case .backButton:
            return Observable.just(.backButtonTapped)
        }
    }
   
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .comfirmButtonTapped:
            state.comfirmButtonTapped = true
        case .backButtonTapped:
            state.backButtonTappedState = true
        }
        return state
    }
}


