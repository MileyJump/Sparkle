//
//  ChannelSearchViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 12/27/24.
//

import UIKit

import ReactorKit
import RealmSwift

class ChannelSearchViewReactor: Reactor {
    
    enum Action {
        case fetchInitialWorkspace
//        case fetchInitialChannel(workspaceId: String)
        case searchUpdate(String)
        
    }
    
    enum Mutation {
        case setWorkspace([WorkspaceListCheckResponse])
        case setChannel([ChannelResponse])
        case error(Error)
        case updateSearch(String)
        
    }
    
    struct State {
        var workspaces: [WorkspaceListCheckResponse] = [WorkspaceListCheckResponse(workspace_id: "", name: "", description: "", coverImage: "", owner_id: "", createdAt: "")]
        var channels: [ChannelResponse] = [ChannelResponse(channel_id: "", name: "", description: "", coverImage: "", owner_id: "", createdAt: "")]
        var filteredChannels: [ChannelResponse] = [ChannelResponse(channel_id: "", name: "", description: "", coverImage: "", owner_id: "", createdAt: "")]
        var error: Error?
        var search: String = ""
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            //        case .fetchInitialChannel(let id):
            //            myChannelListCheck(workspaceID: id)
        case .fetchInitialWorkspace:
               return myWorkspaceListCheck()
                   .flatMap { mutation -> Observable<Mutation> in
                       if case let .setWorkspace(workspaces) = mutation,
                          let firstWorkspace = workspaces.first {
                           return self.myChannelListCheck(workspaceID: firstWorkspace.workspace_id)
                               .startWith(mutation) // 첫 번째 작업 결과도 전달
                       } else {
                           return Observable.just(mutation) // Workspace가 없으면 그대로 반환
                       }
                   }
                   .catch { error in
                       return Observable.just(.error(error))
                   }
               
        case .searchUpdate(let searchText):
            return Observable.just(.updateSearch(searchText))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setWorkspace(let workspaceList):
            newState.workspaces = workspaceList
        case .setChannel(let channelList):
            newState.channels = channelList
        case .error(let error):
            newState.error = error
        case .updateSearch(let searchText):
            newState.search = searchText
            newState.filteredChannels = filterChannels(newState.channels, query: searchText)
        }
        return newState
    }
    
  
    private func filterChannels(_ channels: [ChannelResponse], query: String) -> [ChannelResponse] {
            guard !query.isEmpty else { return channels }
            return channels.filter { $0.name.contains(query) }
        }

    private func myChannelListCheck(workspaceID: String) -> Observable<Mutation> {
        ChannelsNetworkManager.shared.myChannelCheck(parameters: WorkspaceIDParameter(workspaceID: workspaceID))
            .asObservable()
            .flatMap { channelList in
                return Observable.just(Mutation.setChannel(channelList))
            }
            .catch { error in
                return Observable.just(.error(error))
            }
    }
    
    private func myWorkspaceListCheck() -> Observable<Mutation> {
        WorkspaceNetworkManager.shared.workspacesListCheck()
            .asObservable()
            .flatMap { list in
                return Observable.just(Mutation.setWorkspace(list))
            }
            .catch { error in
                return Observable.just(.error(error))
            }
    }
  
}
