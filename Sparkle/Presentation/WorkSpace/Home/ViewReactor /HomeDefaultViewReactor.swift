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
        case fetchChannelData(workspaceID: String)
    }
    
    enum Mutation {
        case createWorkspaceView
        case setChannelsData([ChannelResponse])
        case setError(Error)
    }
    
    struct State {
        var createWorkspace: Bool = false
        var channelData: [ChannelResponse] = []
        var error: Error?
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(createWorkspace: false)
            
    }
    
    func mutate(action: Action) -> Observable<Mutation> {

        switch action {
        case .addChannelsButtonTapped:
            return Observable.just(.createWorkspaceView)
        case .fetchChannelData(let workspaceId):
            return ChannelsNetworkManager.shared.myChannelCheck(parameters: WorkspaceIDParameter(workspaceID: workspaceId))
                .asObservable()
                .do(onNext: { response in
                    print("가져오기 !!@ \(response)========")
                })
                .map { Mutation.setChannelsData($0) }
                .catch { error in
                    return Observable.just(Mutation.setError(error))
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .createWorkspaceView:
            newState.createWorkspace = true
        case .setChannelsData(let channels):
            print("Reduce setChannelsData: \(channels) items")
            newState.channelData = channels
        case .setError(let error):
            newState.error = error
        }
        return newState
    }
}
