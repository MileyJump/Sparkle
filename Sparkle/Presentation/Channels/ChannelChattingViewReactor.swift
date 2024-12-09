//
//  ChannelChattingViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 12/5/24.
//

import UIKit

import ReactorKit
import RealmSwift

class ChatReactor: Reactor {
    
    enum Action {
        case fetchInitialChats(id: ChannelParameter)
        //        case sendMessage(id: ChannelParameter, message: String)
    }
    
    enum Mutation {
        case setCahts([ChatTable])
        //        case addChatMessage(ChannelChatHistoryListResponse)
        case clearInput
        case setError(Error)
    }
    
    struct State {
        var chats: [ChatTable] = []
        //        var channelChat: ChannelChatHistoryListResponse?
        var clearInput: Bool = false
        var error: Error?
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchInitialChats(let id):
            return Observable.concat([
                Observable.just(.setCahts(fetchChatFromRealm())),
                fetchChattingLastDate(id: ChannelParameter(channelID: id.channelID, worskspaceID: id.worskspaceID))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .clearInput:
            newState.clearInput = true
//        case .addChatMessage(let chatResponse):
//            newState.channelChat = chatResponse
        case .setError(let error):
            newState.error = error
        case .setCahts(let chat):
            newState.chats = chat
        }
        return newState
    }
    
    private func fetchChatFromRealm() -> [ChatTable] {
        let repository = ChattingTableRepository()
        return repository.fetchChattingList()
    }
    
    
    // Realm 마지막 날짜를 기준으로 채널 채팅 리스트 조회 후 Realm에 저장 후 Realm 저장 내역 불러오기
    // weak self 🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀
    private func fetchChattingLastDate(id: ChannelParameter) -> Observable<Mutation> {
        let repository = ChattingTableRepository()
        
        // Realm에 저장된 마지막 날짜 가져오기
        guard let lastDate = repository.fetchLastChatCreateAt(), !lastDate.isEmpty else {
            return Observable.just(.setCahts([]))
        }
        
        return fetchChattingListAPI(cursor: lastDate, id: id)
            .asObservable()
            .flatMap { chatResponse -> Observable<Mutation> in
                print("-----")
                let chat = self.responseChatTable(chatResponse)
                repository.createChatItems(chatItem: chat)
                
                return Observable.just(.setCahts(self.fetchChatFromRealm()))
            }
            .catch { error in
                return Observable.just(.setError(error))
            }
    }
    
    // 채널 채팅 리스트 조회
    private func fetchChattingListAPI(cursor: String, id: ChannelParameter) -> Single<[ChannelChatHistoryListResponse]>  {
        
        let api = ChannelsNetworkManager.shared.channelChatHistoryList(parameters: ChannelChatHistoryListParameter(cursor_date: cursor, channelID: id.channelID, workspaceId: id.worskspaceID))
        return api
    }
    
    
    // 채팅 리스트 Realm에 저장
//    private func saveChatToRealm(_ chats: [ChatTable]) {
//        let repository = ChattingTableRepository()
//        
//        repository.createChatItems(chatItem: chats)
//    }
    
    // 채팅 리스트를 Realm Table로 변환
    private func responseChatTable(_ response: [ChannelChatHistoryListResponse]) -> [ChatTable] {
        
        let chat = response.map { chat in
            ChatTable(channelId: chat.channel_id, channelName: chat.channelName, chatContent: chat.content, chatCreateAt: chat.createdAt, files: [], user: UserTable(userId: chat.user.user_id, email: chat.user.email, nickname: chat.user.nickname, profilImage: chat.user.profileImage))
        }
        
        return chat
    }
    
    
//    private f/]unc performChannelChat(chatId: ChannelParameter,  message: String) -> Observable<Mutation> {
 //        let repository = ChattingTableRepository()
 ////        let realm = try! Realm()
 //
 //        return ChannelsNetworkManager.shared.sendChannelChat(query: SendChannelChatQuery(content: message, files: []), parameters: ChannelParameter(channelID: chatId.channelID, worskspaceID: chatId.worskspaceID))
 //            .asObservable()
 //            .flatMap({ chatResponse -> Observable<Mutation> in
 //
 //                // 여기 조금 깔끔하게 하는 법 없는지 생각해보기 !! 🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀
 //                let chat = ChatTable(channelId: chatResponse.channel_id, channelName: chatResponse.channelName, chatContent: chatResponse.content, chatCreateAt: chatResponse.createdAt, files: chatResponse.files, user: UserTable(userId: chatResponse.user.user_id, email: chatResponse.user.email, nickname: chatResponse.user.nickname, profilImage: chatResponse.user.profileImage))
 //
 //                repository.createChatItem(chatItem: chat)
 //                print(realm.configuration.fileURL ?? "")
 //                return Observable.just(.addChatMessage(chatResponse))
 //            })
 //            .catch { error in
 //                return Observable.just(.setError(error))
 //            }
 //    }
}
