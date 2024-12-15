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
        case sendMessage(id: ChannelParameter, message: String)
        case connectSocket(channelId: String)
    }
    
    enum Mutation {
        case setChats([ChatTable])
        case addChatMessage([ChatTable])
        case clearInput
        case setError(Error)
    }
    
    struct State {
        var chats: [ChatTable] = [ChatTable(chatId: "", channelId: "", channelName: "", chatContent: "", chatCreateAt: "", files: [], user: UserTable(userId: "", email: "", nickname: "", profilImage: ""))]
        var clearInput: Bool = false
        var error: Error?
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchInitialChats(let id):
            return Observable.concat([
                Observable.just(.setChats(fetchChatFromRealm(channelId: id.channelID))),
                fetchChattingLastDate(id: id)
            ])
        case .sendMessage(id: let id, message: let message):
                sendChatMessage(message: message, id: id)
                return Observable.just(.clearInput)
        case .connectSocket(let channelId):
            return connectToSocket(channelId: channelId)
                .flatMap { mutation -> Observable<Mutation> in
                    // 새로운 메시지가 수신되면 UI 갱신 및 Realm 저장
                    switch mutation {
                    case .addChatMessage(let chat):
                        let repository = ChattingTableRepository()
                        repository.createChatItems(chatItem: chat)
                        return Observable.just(.addChatMessage(chat))
                    default:
                        return Observable.just(mutation)
                    }
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
         var newState = state
         switch mutation {
         case .setChats(let chats):
             newState.chats = chats
         case .addChatMessage(let chats):
             newState.chats.append(contentsOf: chats)
         case .clearInput:
             newState.clearInput = true
         case .setError(let error):
             newState.error = error
         }
         return newState
     }

    var disposeBag = DisposeBag()
    
    private func connectToSocket(channelId: String) -> Observable<Mutation> {
        let socketManager = SocketIOManager(channelId: channelId)
        
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            socketManager.connect(channelId: channelId)
            
            socketManager.listenForMessages()
                .map { [weak self] message -> Mutation in
                    guard let self = self else { return .setError(SocketError.connectionError("Reactor is nil")) }
                    let chat = self.responseChatTables(message)
                    ChattingTableRepository().createChatItem(chatItem: chat)
                    return .addChatMessage([chat])
                }
                .subscribe(onNext: { mutation in
                    observer.onNext(mutation)
                }, onError: { error in
                    observer.onError(error)
                })
                .disposed(by: self.disposeBag)

            return Disposables.create {
                socketManager.disconnect()
            }
        }
        .catch { error in
            return Observable.just(.setError(error))
        }
    }

    
    // realm에 저장된 내역을 불러오기
    private func fetchChatFromRealm(channelId: String) -> [ChatTable] {
        let repository = ChattingTableRepository()
        let chats = repository.fetchChannelChattingList(channelId: channelId)
        
        guard !chats.isEmpty else {
            print("fetchChatFromRealm : Realm 에 저장된 채팅 내역이 없습니다.")
            return []
        }
        return chats
    }
    
    
    // Realm 마지막 날짜를 기준으로 채널 채팅 리스트 조회 후 Realm에 저장 후 Realm 저장 내역 불러오기
    // weak self 🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀
    private func fetchChattingLastDate(id: ChannelParameter) -> Observable<Mutation> {
        let repository = ChattingTableRepository()
        
        // Realm에 저장된 마지막 날짜 가져오기
        guard let lastDate = repository.fetchLastChatCreateAt(), !lastDate.isEmpty else {
            return Observable.just(.setChats([]))
        }
        
        return fetchChattingListAPI(cursor: lastDate, id: id)
            .asObservable()
            .flatMap { chatResponse -> Observable<Mutation> in
                let chat = self.responseChatTable(chatResponse)
                repository.createChatItems(chatItem: chat)
                
                return Observable.just(.setChats(self.fetchChatFromRealm(channelId: id.channelID)))
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
    
    
    // 채팅 리스트를 Realm Table로 변환
    private func responseChatTable(_ response: [ChannelChatHistoryListResponse]) -> [ChatTable] {
        
        let chat = response.map { chat in
            ChatTable(chatId: chat.chat_id, channelId: chat.channel_id, channelName: chat.channelName, chatContent: chat.content, chatCreateAt: chat.createdAt, files: [], user: UserTable(userId: chat.user.user_id, email: chat.user.email, nickname: chat.user.nickname, profilImage: chat.user.profileImage))
        }
        return chat
    }
    
    private func responseChatTables(_ response: ChannelChatHistoryListResponse) -> ChatTable {
        
        let chat =
        ChatTable(chatId: response.chat_id, channelId: response.channel_id, channelName: response.channelName, chatContent: response.content, chatCreateAt: response.createdAt, files: [], user: UserTable(userId: response.user.user_id, email: response.user.email, nickname: response.user.nickname, profilImage: response.user.profileImage))
        
        return chat
    }
    
    private func sendChatMessage(message: String, id: ChannelParameter) {
        
        ChannelsNetworkManager.shared.sendChannelChat(query: SendChannelChatQuery(content: message, files: []), parameters: ChannelParameter(channelID: id.channelID, worskspaceID: id.worskspaceID))
            .subscribe(with: self, onSuccess: { _, response in
                print("😊😊😊😊 sendChatMessage response : \(response)😊😊😊")
            }, onFailure: { _, error in
                print("😊 에러 : \(error)😊")
            })
            .disposed(by: disposeBag)
    }
    
//    private func sendChatMessage(message: String, id: ChannelParameter) -> Observable<Mutation> {
////        let repository = ChattingTableRepository()
//        
//        return ChannelsNetworkManager.shared.sendChannelChat(query: SendChannelChatQuery(content: message, files: []), parameters: ChannelParameter(channelID: id.channelID, worskspaceID: id.worskspaceID))
//            .asObservable()
//            .flatMap { response in
//                print("😊😊😊😊 \(response)😊😊😊")
//
//                
//                return Observable.just(Mutation.addChatMessage(self.fetchChatFromRealm(channelId: id.channelID)))
//            }
//            .catch { error in
//                print("😊 에러 : \(error)😊")
//                return Observable.just(Mutation.setError(error))
//            }
//    }
}
