//
//  HomeDefaultViewController.swift
//  Sparkle
//
//  Created by 최민경 on 11/22/24.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa

final class HomeDefaultViewController: BaseViewController<HomeDefaultView> {
    
    var disposeBag = DisposeBag()
    private var workspaceId: String?
    
    init(workspaceId: String?) {
        self.workspaceId = workspaceId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeVC - ViewDidLoad")
        self.reactor = HomeDefaultViewReactor()
    }
    
    override func setupUI() {
        rootView.channelTableView.rowHeight = UITableView.automaticDimension
        rootView.channelTableView.estimatedRowHeight = 44
        rootView.channelTableView.separatorStyle = .none
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //        rootView.updateChannelTableViewHeight()
        rootView.updateDirectTableViewHeight()
    }
}


extension HomeDefaultViewController: View {
    
    func bind(reactor: HomeDefaultViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: HomeDefaultViewReactor) {
        
        Observable.just(workspaceId)
            .compactMap { $0 }
            .map { HomeDefaultViewReactor.Action.fetchChannelData(workspaceID: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        rootView.addChannelButton.rx.tap
            .map { HomeDefaultViewReactor.Action.addChannelsButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        rootView.channelTableView.rx.modelSelected(ChannelResponse.self)
            .map { HomeDefaultViewReactor.Action.channelSelected(id: ChannelParameter(channelID: $0.channel_id, worskspaceID: self.workspaceId ?? "")) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: HomeDefaultViewReactor) {
        //
        // 이 updateChannelTableViewHeight 가 왜 중복 호출해야지만 레이아웃이 제대로 잡히는지에 대해서 공부해보기!! 🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀
        reactor.state.map { $0.channelData }
        //            .distinctUntilChanged()
            .bind(with: self) { owner, _ in
                owner.rootView.updateChannelTableViewHeight()
                //                owner.rootView.layoutIfNeeded()
            }
            .disposed(by: disposeBag)
        //
        reactor.state.map { $0.createWorkspace }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.navigationController?.changePresentViewController(CreateWorkspaceViewController())
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map{ $0.channelData }
            .asObservable()
            .bind(to: rootView.channelTableView.rx.items(cellIdentifier: ChannelsTableViewCell.identifier, cellType: ChannelsTableViewCell.self)) { (row, channel, cell) in
                cell.bind(channel: channel)
                self.rootView.updateChannelTableViewHeight()
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.dmsData }
            .asObservable()
            .bind(to: rootView.directTableView.rx.items(cellIdentifier: UserTableViewCell.identifier, cellType: UserTableViewCell.self)) { (row, dm, cell) in
                cell.bind(dms: dm)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.seletedChannel }
            .distinctUntilChanged { old, new in
                old?.channelID == new?.channelID
            }
            .compactMap{ $0 }
            .bind(with: self) { owner, channel in
                let vc = ChannelChattingViewController(channelId: channel.channelID, workspaceId: owner.workspaceId)
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}

