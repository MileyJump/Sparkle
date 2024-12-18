//
//  OnboardingViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 12/18/24.
//

import ReactorKit
import RxSwift
import RxCocoa

final class OnboardingViewReactor: Reactor {
    
    
    
    enum Action {
        case startButtonTapped
    }
    
    enum Mutation {
        case setLoginViewControllerPresented(Bool)
    }
    
    var initialState = State()
    
    struct State {
        var isLoginViewControllerPresented: Bool = false
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .startButtonTapped:
            return Observable.just(Mutation.setLoginViewControllerPresented(true))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoginViewControllerPresented(let presented):
            newState.isLoginViewControllerPresented = presented
        }
        return newState
    }
}
