//
//  HomeViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 11/8/24.
//

import ReactorKit
import RxSwift
import RxCocoa

final class ViewReactor: Reactor {
    
    enum Action {
        case xmark
        case decrease
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
        case alertMessage(String)
    }
    
    struct State {
        var value: Int
        var setLoading: Bool
        @Pulse var alertMessage: String?
    }
    
    let initialState: State
    
    // 처음 상태를 작성하기 위해서 사용
    init() {
        self.initialState = State(value: 0, setLoading: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat(
                Observable.just(Mutation.increaseValue),
                Observable.just(Mutation.setLoading(false)),
                Observable.just(Mutation.alertMessage("increase"))
                
            )
        case .decrease:
            return Observable.concat(
                Observable.just(Mutation.decreaseValue),
                Observable.just(Mutation.setLoading(false)),
                Observable.just(Mutation.alertMessage("decrease"))
            )
        }
    }
   
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .increaseValue:
            state.value += 1
        case .decreaseValue:
            state.value -= 1
        case .setLoading(let bool):
            state.setLoading = bool
        case .alertMessage(let string):
            state.alertMessage = string
        }
        
        return state
    }
}

