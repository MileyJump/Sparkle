//
//  ChannelChattingViewController.swift
//  Sparkle
//
//  Created by 최민경 on 12/5/24.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

import RealmSwift

class ChannelChattingViewController: BaseViewController<ChannelChattingView> {
    
    var disposeBag = DisposeBag()
    
    let realm = try! Realm()
    private var workspaceId: String?
    private var channelId: String?
    
    init(channelId: String, workspaceId: String?) {
        self.channelId = channelId
        self.workspaceId = workspaceId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.reactor = ChatReactor()
        
        guard let channelId = self.channelId else { return }
           reactor?.action.onNext(.connectSocket(channelId: channelId))
    
     
    }
    
    private func handleNewMessage(_ message: ChannelChatHistoryListResponse) {
        let repository = ChattingTableRepository()
        let chat = responseChatTables(message)
        repository.createChatItem(chatItem: chat)
        // 테이블 뷰 갱신 로직 추가
    }
    
    private func responseChatTables(_ response: ChannelChatHistoryListResponse) -> ChatTable {
        return ChatTable(
            chatId: response.chat_id,
            channelId: response.channel_id,
            channelName: response.channelName,
            chatContent: response.content,
            chatCreateAt: response.createdAt,
            files: response.files,
            user: UserTable(
                userId: response.user.user_id,
                email: response.user.email,
                nickname: response.user.nickname,
                profilImage: response.user.profileImage
            )
        )
    }
}

extension ChannelChattingViewController: View {
    
    func bind(reactor: ChatReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: ChatReactor) {
        
        if let channelId , let workspaceId {
            
            reactor.action.onNext(.fetchInitialChats(id: ChannelParameter(channelID: channelId, worskspaceID: workspaceId)))
        }
        
        rootView.sendButton.rx.tap
            .withLatestFrom(rootView.messageTextView.rx.text.orEmpty)
            .map { [weak self ] message in
                let channelId = self?.channelId ?? ""
                let workspaceId = self?.workspaceId ?? ""
                return ChatReactor.Action.sendMessage(id: ChannelParameter(channelID: channelId, worskspaceID: workspaceId), message: message)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: ChatReactor) {
        
        reactor.state
            .map { $0.clearInput }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self, onNext: { owner, _ in
                owner.rootView.messageTextView.text = ""
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.chats }
            .asObservable()
            .bind(to: rootView.channelTableView.rx.items(cellIdentifier: ChannelChattingCell.identifier, cellType: ChannelChattingCell.self)) { (row, chat, cell) in
                cell.bind(chat)
            }
            .disposed(by: disposeBag)
    }

}
