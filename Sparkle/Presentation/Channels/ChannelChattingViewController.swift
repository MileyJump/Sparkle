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
        setupNavigationBarButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("=====deinit")
        if let channelId {
            self.reactor?.action.onNext(.disconnectSocket(channelId: channelId))
        }
    }
    
     func setupNavigationBarButton() {
        super.setupNavigationBar()
        
        let setting = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: nil, action: nil)
        
        
        navigationItem.rightBarButtonItem = setting
        
        setting.rx.tap
            .compactMap { [weak self] in self?.reactor }
            .map { _ in ChatReactor.Action.settingButtonTapped }
            .bind(with: self) { owner, action in
                owner.reactor?.action.onNext(action)
            }
            .disposed(by: disposeBag)
        
    }
}

extension ChannelChattingViewController: View {
    
    func bind(reactor: ChatReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: ChatReactor) {
        
        if let channelId {
            if let workspaceId = reactor.workspaceIDrepository.fetchWorksaceID() {
                reactor.action.onNext(.fetchInitialChats(id: ChannelParameter(channelID: channelId, workspaceID: workspaceId)))
            }
        }
        
        rootView.sendButton.rx.tap
            .withLatestFrom(rootView.messageTextView.rx.text.orEmpty)
            .map { [weak self ] message in
                let channelId = self?.channelId ?? ""
                let workspaceId = self?.workspaceId ?? ""
                return ChatReactor.Action.sendMessage(id: ChannelParameter(channelID: channelId, workspaceID: workspaceId), message: message)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: ChatReactor) {
        
        reactor.state
            .map { $0.channelName }
            .distinctUntilChanged()
            .bind(with: self) { owner, channelName in
                owner.navigationItem.title = channelName
            }
            .disposed(by: disposeBag)
        
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
        
        reactor.state
            .map { $0.setIsSettingNavigationBarEnabled }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { owner, _ in
                if let channelId = owner.channelId, let workspaceId = owner.workspaceId {
                    let settingsVC = ChannelSettingViewController(channelId: channelId, workspaceId: workspaceId)
                    owner.navigationController?.pushViewController(settingsVC, animated: true)
                }
            }
            .disposed(by: disposeBag)
    }

}
