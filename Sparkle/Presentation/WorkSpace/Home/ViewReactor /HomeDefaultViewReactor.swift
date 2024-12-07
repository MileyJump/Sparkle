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
        case fetchDMsData(workspaceID: String)
        case channelSelected(id: ChannelParameter)
    }
    
    enum Mutation {
        case createWorkspaceView
        case setChannelsData([ChannelResponse])
        case setDMsData([DmsListCheckResponse])
        case setError(Error)
        case setIsPushChannelEnabled(Bool)
        case setSelectedChannel(ChannelParameter)
        
    }
    
    struct State {
        var createWorkspace: Bool = false
        var channelData: [ChannelResponse] = [ChannelResponse(channel_id: "d083709a-0885-4179-9878-706e65f50e1b", name: "><", description: "", coverImage: "ㅇ", owner_id: "b0365afe-a99d-4d3b-ab7d-4897c3aed288", createdAt: "create")]
//        var channelData: [ChannelResponse] = []
        //
        var error: Error?
        var dmsData: [DmsListCheckResponse] = [DmsListCheckResponse(room_id: "", createdAt: "", user: UserMemberResponse(user_id: "", email: "", nickname: "", profileImage: ""))]
        var isPushChannelEnabled: Bool = false
        var seletedChannel: ChannelParameter?
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
                .map { Mutation.setChannelsData($0) }
                .catch { error in
                    return Observable.just(Mutation.setError(error))
                }
        case .fetchDMsData(let workspaceID):
            return DMSNetworkManager.shared.dmsListCheck(parameters: WorkspaceIDParameter(workspaceID: workspaceID))
                .asObservable()
                .map { Mutation.setDMsData($0) }
                .catch { error in
                    return Observable.just(Mutation.setError(error))
                }
   
//        case .channelSelected(ChannelParameter(channelID: let channeldID, worskspaceID: let workspaceID)) :
//        case .channelSelected(let id):
//            return Observable.concat([
//                Observable.just(.setIsPushChannelEnabled(true)),
//                Observable.just(.setIsPushChannelEnabled(false))
//            ])
        case .channelSelected(id: let id):
            return Observable.concat([
                Observable.just(Mutation.setSelectedChannel(id)),
                Observable.just(Mutation.setIsPushChannelEnabled(true)),
                Observable.just(.setIsPushChannelEnabled(false))
                        ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .createWorkspaceView:
            newState.createWorkspace = true
        case .setChannelsData(let channels):
            newState.channelData = Array(channels)
        case .setDMsData(let dms):
            newState.dmsData = Array(dms)
        case .setError(let error):
            newState.error = error
        case .setIsPushChannelEnabled(let isPresent):
            newState.isPushChannelEnabled = isPresent
        
        case .setSelectedChannel(let channel):
            newState.seletedChannel = channel
        }
        return newState
    }
}
