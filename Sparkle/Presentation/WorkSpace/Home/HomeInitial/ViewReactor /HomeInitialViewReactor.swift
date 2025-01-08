//
//  HomeInitialViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 11/11/24.
//


import ReactorKit
import RxSwift

class HomeInitialViewReactor: Reactor {
    
    enum Action {
        case toggleSection(Int)
    }
    
    enum Mutation {
        case toggleSection(Int)
    }
    
    struct State {
        var sections: [(title: String, isExpanded: Bool, items: [String])]
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(
            sections: [
                (title: "채널", isExpanded: true, items: ["일반", "채널 추가"]),
                (title: "다이렉트 메시지", isExpanded: false, items: ["팀원 추가"])
            ]
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .toggleSection(let index):
            return Observable.just(.toggleSection(index))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .toggleSection(let index):
            newState.sections[index].isExpanded.toggle()
        }
        return newState
    }
}
