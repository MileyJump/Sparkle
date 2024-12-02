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
    }
    
    enum Mutation {
        case createWorkspaceView
        case setChannelsData([ChannelResponse])
        case setDMsData([DmsListCheckResponse])
        case setError(Error)
        
    }
    
    struct State {
        var createWorkspace: Bool = false
        var channelData: [ChannelResponse] = [ChannelResponse(channel_id: "d083709a-0885-4179-9878-706e65f50e1b", name: "><", description: "", coverImage: "ㅇ", owner_id: "b0365afe-a99d-4d3b-ab7d-4897c3aed288", createdAt: "create")]
//        var channelData: [ChannelResponse] = []
        //
        var error: Error?
        var dmsData: [DmsListCheckResponse] = [DmsListCheckResponse(room_id: "", createdAt: "", user: UserMemberResponse(user_id: "", email: "", nickname: "", profileImage: ""))]
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
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .createWorkspaceView:
            newState.createWorkspace = true
        case .setChannelsData(let channels):
            print("DEBUG: 리듀서에서 채널 데이터 설정")
            print("DEBUG: 받은 채널 개수: \(channels.count)")
            print("DEBUG: 채널 데이터: \(channels)")
            newState.channelData = Array(channels)
            print("DEBUG: 새로운 channelData: \(newState.channelData)")
        case .setDMsData(let dms):
            newState.dmsData = Array(dms)
        case .setError(let error):
            print("DEBUG: 에러 발생: \(error)")
            newState.error = error
        }
        return newState
    }
}
