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
        case fetchInitialWorkspaceList
        case addChannelsButtonTapped
        case fetchDMsData(workspaceID: String)
        case channelSelected(id: ChannelParameter)
        case clickWorkspaceList
    }
    
    enum Mutation {
        case setWorkspaceList([WorkspaceListCheckResponse])
        case createWorkspaceView
        case setChannelsData([ChannelResponse])
        case setDMsData([DmsListCheckResponse])
        case setError(Error)
        case setIsPushChannelEnabled(Bool)
        case setSelectedChannel(ChannelParameter)
        case setIsWorkspaceListEnabled(Bool)
        
    }
    
    struct State {
        var workspaceList: [WorkspaceListCheckResponse] = []
        var createWorkspace: Bool = false
        var channelData: [ChannelResponse] = [ChannelResponse(channel_id: "d083709a-0885-4179-9878-706e65f50e1b", name: "><", description: "", coverImage: "ㅇ", owner_id: "b0365afe-a99d-4d3b-ab7d-4897c3aed288", createdAt: "create")]
        var error: Error?
        var dmsData: [DmsListCheckResponse] = [DmsListCheckResponse(room_id: "", createdAt: "", user: UserMemberResponse(user_id: "", email: "", nickname: "", profileImage: ""))]
        var isPushChannelEnabled: Bool = false
        var seletedChannel: ChannelParameter?
        var isWorkspaceListEnabled: Bool = false
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(createWorkspace: false)
            
    }
    
    func mutate(action: Action) -> Observable<Mutation> {

        switch action {
        case .fetchInitialWorkspaceList:
            return workspaceListCheck()
                .flatMap { [weak self] mutation -> Observable<Mutation> in
                    guard let self = self else { return Observable.empty() }
                    if case let .setWorkspaceList(workspaceList) = mutation {
                        if let latestWorkspace = workspaceList.sorted(by: { $0.createdAt > $1.createdAt }).first {
                            let workspaceID = latestWorkspace.workspace_id
                            let id = WorkspaceIDTable(workspaceID: workspaceID)
                            repository.createWorkspaceID(id: id)
                            print("😈😈😈😈😈😈😈😈😈😈😈😈😈Realm WorkspaceID : \(repository.fetchWorksaceID())")
                            return self.fetchChannelData(workspaceId: workspaceID)
                                .startWith(mutation) //  fetchChannelData 결과 방출 전에 setWorkspaceList 먼저 전달
                        }
                    }
                    return Observable.just(mutation)
                }
            
        case .addChannelsButtonTapped:
            return Observable.just(.createWorkspaceView)
            
        case .fetchDMsData(let workspaceID):
            return DMSNetworkManager.shared.dmsListCheck(parameters: WorkspaceIDParameter(workspaceID: workspaceID))
                .asObservable()
                .map { Mutation.setDMsData($0) }
                .catch { error in
                    return Observable.just(Mutation.setError(error))
                }
  
        case .channelSelected(id: let id):
            if let workspaceID = repository.fetchWorksaceID() {
                let updatedChannel = ChannelParameter(channelID: id.channelID, workspaceID: workspaceID)
                return Observable.concat([
                    Observable.just(Mutation.setSelectedChannel(updatedChannel)),
                    Observable.just(Mutation.setIsPushChannelEnabled(true)),
                    Observable.just(Mutation.setIsPushChannelEnabled(false))
                ])
            } else {
                return Observable.empty()
            }
            
        case .clickWorkspaceList:
            return Observable.concat([
                Observable.just(.setIsWorkspaceListEnabled(true)),
                Observable.just(.setIsWorkspaceListEnabled(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setWorkspaceList(let list):
            newState.workspaceList = list
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
        case .setIsWorkspaceListEnabled(let isPresent):
            newState.isWorkspaceListEnabled = isPresent
        }
        return newState
    }
    
     let repository = WorkspaceTableRepository()
    
    private func workspaceListCheck() -> Observable<Mutation> {
        WorkspaceNetworkManager.shared.workspacesListCheck()
            .asObservable()
            .flatMap { list in
                return Observable.just(Mutation.setWorkspaceList(list))
                
            }
            .catch { error in
                return Observable.just(.setError(error))
            }
    }
    
    private func fetchChannelData(workspaceId: String) -> Observable<Mutation> {
        return ChannelsNetworkManager.shared.myChannelCheck(parameters: WorkspaceIDParameter(workspaceID: workspaceId))
            .asObservable()
            .map { Mutation.setChannelsData($0) }
            .catch { error in
                return Observable.just(Mutation.setError(error))
            }
    }

}
