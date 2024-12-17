//
//  ChannelSettingViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 12/17/24.
//

import UIKit

import ReactorKit
import RealmSwift

class ChannelSettingViewReactor: Reactor {
    
    enum Action {
        case fetchInitialChannelInform(id: ChannelParameter)
        case toggleMemberCollection
        
    }
    
    enum Mutation {
        case setChannelInform(SpecificChannelCheckResponse)
        case setMemberList([UserMemberResponse])
        case toggleMemberCollection
        case setError(Error)
        
    }
    
    struct State {
        var channelInform: SpecificChannelCheckResponse = SpecificChannelCheckResponse(channel_id: "", name: "", description: "", coverImage: "", owner_id: "", createdAt: "", channelMembers: [UserMemberResponse(user_id: "", email: "", nickname: "", profileImage: "")])
        var memberList: [UserMemberResponse] = [UserMemberResponse(user_id: "", email: "", nickname: "", profileImage: "")]
        var isMemberCollectionVisible: Bool = true
        var isChevronDown: Bool = true  // chevron 상태 관리
        var error: Error?
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchInitialChannelInform(id: let id):
            
            return memberCheckList(id: id)
                .asObservable()
                .flatMap { response -> Observable<Mutation> in
                    return Observable.concat([
                        Observable.just(.setChannelInform(response)),
                        Observable.just(.setMemberList(response.channelMembers))
                    ])
                    
                }
                .catch { error in
                    print(error)
                    return Observable.just(.setError(error))
                }
        case .toggleMemberCollection:
            return Observable.just(.toggleMemberCollection)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setChannelInform(let channelInform):
            newState.channelInform = channelInform
        case .setError(let error):
            newState.error = error
        case .setMemberList(let memberList):
            newState.memberList = memberList
        case .toggleMemberCollection:
            newState.isMemberCollectionVisible.toggle()
            newState.isChevronDown.toggle()
        }
        return newState
    }
        
    private func memberCheckList(id: ChannelParameter) -> Single<SpecificChannelCheckResponse>  {
        return ChannelsNetworkManager.shared.specificChannelCheck(parameters: id)
    }
    
}
