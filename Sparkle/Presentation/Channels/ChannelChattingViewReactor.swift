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
        case disconnectSocket(channelId: String)
        case settingButtonTapped
    }
    
    enum Mutation {
        case setChats([ChatTable])
        case addChatMessage([ChatTable])
        case clearInput
        case setError(Error)
        case setChannelName(String)
        case setSettingNavigationBarEnabled(Bool)
        case setChannelId(String)
    }
    
    struct State {
        var chats: [ChatTable] = [ChatTable(chatId: "", channelId: "", channelName: "", chatContent: "", chatCreateAt: "", files: [], user: UserTable(userId: "", email: "", nickname: "", profilImage: ""))]
        var clearInput: Bool = false
        var error: Error?
        var isDisconnected: Bool = false
        var channelName: String = ""
        var setIsSettingNavigationBarEnabled: Bool = false
        var channelId: String?
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchInitialChats(let id):
//            print("idggg: \(id)")
//            let initialChats = fetchChatFromRealm(channelId: id.channelID)
//            print("initialChats: \(initialChats)")
//            let channelName = initialChats.first?.channelName ?? "개발자 동기 수다방"
//            
//            return Observable.concat([
//                Observable.just(.setChannelName(channelName)),
//                Observable.just(.setChats(initialChats)),
//                fetchChattingLastDate(id: id)
//                    .concat(Observable.create { [weak self] observer in
//                        guard let self = self else {
//                            observer.onCompleted()
//                            return Disposables.create()
//                        }
//                        // API 호출 및 갱신이 완료된 후 소켓 연결
//                        self.startSocketConnection(channelId: id.channelID, observer: observer)
//                        return Disposables.create()
//                    })
//            ])
            return Observable.concat([
                       Observable.just(.setChannelId(id.channelID)), // 채널 ID 설정
                       handleFetchInitialChats(id: id)
                   ])
            
        case .sendMessage(id: let id, message: let message):
            sendChatMessage(message: message, id: id)
            return Observable.just(.clearInput)
            
        case .disconnectSocket(let channelId):
//            let socketManager = SocketIOManager(channelId: channelId)
            self.socketManager?.disconnect()
            disconnectSocket(channelId: channelId)
//            socketManager.disconnect()
//            return Observable.just(.disconnectSocket)
            return Observable.empty()
            
        case .settingButtonTapped:
            return Observable.concat([
                
                Observable.just(Mutation.setSettingNavigationBarEnabled(true)),
                Observable.just(Mutation.setSettingNavigationBarEnabled(false))
            ])
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
        case .setChannelName(let name):
            newState.channelName = name
        case .setSettingNavigationBarEnabled(let enabled):
            newState.setIsSettingNavigationBarEnabled = enabled
        case .setChannelId(let channelId):
            newState.channelId = channelId
        }
        return newState
    }
    
    private var disposeBag = DisposeBag()
    
    private let repository = ChattingTableRepository()
    let workspaceIDrepository = WorkspaceTableRepository()
    private var socketManager: SocketIOManager?
    
    init() {
           // Rx 방식으로 앱 상태 감지 및 소켓 연결 관리
           Observable.merge(
               NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification).map { _ in false },
               NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification).map { _ in true }
           )
           .distinctUntilChanged()
           .subscribe(onNext: { [weak self] isActive in
               guard let self = self, let channelId = self.currentState.channelId else { return }
               if isActive {
                   self.reconnectSocket(channelId: channelId)
               } else {
                   self.disconnectSocket(channelId: channelId)
               }
           })
           .disposed(by: disposeBag)
       }
    
    private func handleFetchInitialChats(id: ChannelParameter) -> Observable<Mutation> {
            let initialChats = fetchChatFromRealm(channelId: id.channelID)
            let channelName = initialChats.first?.channelName ?? "Default Channel"
            
            return Observable.concat([
                Observable.just(.setChannelName(channelName)),
                Observable.just(.setChats(initialChats)),
                fetchChattingLastDate(id: id)
                    .concat(Observable.create { [weak self] observer in
                        guard let self = self else {
                            observer.onCompleted()
                            return Disposables.create()
                        }
                        self.startSocketConnection(channelId: id.channelID, observer: observer)
                        return Disposables.create()
                    })
            ])
        }
        
        private func reconnectSocket(channelId: String) {
            connectToSocket(channelId: channelId)
                .subscribe(onNext: { mutation in
                    print("✅ 소켓 재연결 성공: \(mutation)")
                }, onError: { error in
                    print("❌ 소켓 재연결 실패: \(error)")
                })
                .disposed(by: disposeBag)
        }
    
    
    private func startSocketConnection(channelId: String, observer: AnyObserver<Mutation>) {
        connectToSocket(channelId: channelId)
            .subscribe(onNext: { mutation in
                observer.onNext(mutation)
            }, onError: { error in
                observer.onError(error)
            }, onCompleted: {
                observer.onCompleted()
            })
            .disposed(by: disposeBag)
    }
    
    private func connectToSocket(channelId: String) -> Observable<Mutation> {
        let socketManager = SocketIOManager(channelId: channelId)
        self.socketManager = socketManager
        
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            socketManager.connect()
            
            socketManager.listenForMessages()
                .map { [weak self] message -> Mutation in
                    guard let self = self else { return .setError(SocketError.connectionError("Reactor is nil")) }
                    let chat = self.responseChatTables(message)
                    repository.createChatItem(chatItem: chat)
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
    
    private func disconnectSocket(channelId: String) {
        let socketManager = SocketIOManager(channelId: channelId)
        socketManager.disconnect() // 소켓 연결 해제
    }
    
    // realm에 저장된 내역을 불러오기
    private func fetchChatFromRealm(channelId: String) -> [ChatTable] {
        
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

        // Realm에 저장된 마지막 날짜 가져오기
        guard let lastDate = repository.fetchLastChatCreateAt(), !lastDate.isEmpty else {
            return Observable.just(.setChats([]))
        }
        
        return fetchChattingListAPI(cursor: lastDate, id: id)
            .asObservable()
            .flatMap { chatResponse -> Observable<Mutation> in
                let chat = self.responseChatTable(chatResponse)
                self.repository.createChatItems(chatItem: chat)
                
                return Observable.just(.setChats(self.fetchChatFromRealm(channelId: id.channelID)))
            }
            .catch { error in
                return Observable.just(.setError(error))
            }
    }
    
    // 채널 채팅 리스트 조회
    private func fetchChattingListAPI(cursor: String, id: ChannelParameter) -> Single<[ChannelChatHistoryListResponse]>  {
        
        let api = ChannelsNetworkManager.shared.channelChatHistoryList(parameters: ChannelChatHistoryListParameter(cursor_date: cursor, channelID: id.channelID, workspaceId: id.workspaceID))
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
        
        ChannelsNetworkManager.shared.sendChannelChat(query: SendChannelChatQuery(content: message, files: []), parameters: ChannelParameter(channelID: id.channelID, workspaceID: id.workspaceID))
            .subscribe(with: self, onSuccess: { _, response in
                print("😊😊😊😊 sendChatMessage response : \(response)😊😊😊")
            }, onFailure: { _, error in
                print("😊 에러 : \(error)😊")
            })
            .disposed(by: disposeBag)
    }
}
