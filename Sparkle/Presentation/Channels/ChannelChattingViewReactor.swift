//
//  ChannelChattingViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 12/5/24.
//

import UIKit

import ReactorKit

class ChatReactor: Reactor {

    enum Action {
        case sendMessage(String)
    }

    enum Mutation {
        case addMessage(String)
        case clearInput
    }

    struct State {
        var messages: [String] = []
        var clearInput: Bool = false
    }

    let initialState = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .sendMessage(let message):
            return Observable.concat([
                Observable.just(.addMessage(message)),
                Observable.just(.clearInput)
            ])
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .addMessage(let message):
            newState.messages.append(message)
        case .clearInput:
            newState.clearInput = true
        }
        return newState
    }
}
