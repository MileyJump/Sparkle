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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("=====deinit")
        if let channelId {
            self.reactor?.action.onNext(.disconnectSocket(channelId: channelId))
        }
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
