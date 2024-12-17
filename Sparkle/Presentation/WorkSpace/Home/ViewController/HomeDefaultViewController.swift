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

//    private var workspace: WorkspaceListCheckResponse?
    
    
//    init(workspace: WorkspaceListCheckResponse?) {
//        self.workspace = workspace
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeVC - ViewDidLoad")
        self.reactor = HomeDefaultViewReactor()
        
        setupWorkspaceNavigationBar()
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
    
     func setupWorkspaceNavigationBar() {
        let navigationBar = WorkspaceCustomNavigationBar(workspaceImageName: "테스트 사진", title: "No Workspace", profileImageName: "테스트 사진")
        
        navigationItem.titleView = navigationBar
        
        bindNavigationBar(navigationBar)
    }
}


extension HomeDefaultViewController: View {
    
    func bind(reactor: HomeDefaultViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: HomeDefaultViewReactor) {
        
        reactor.action.onNext(.fetchInitialWorkspaceList)
        
        rootView.addChannelButton.rx.tap
            .map { HomeDefaultViewReactor.Action.addChannelsButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        rootView.channelTableView.rx.modelSelected(ChannelResponse.self)
            .compactMap { [weak self] channel -> HomeDefaultViewReactor.Action? in
                guard let self = self else { return nil }
                let workspaceID = self.reactor?.repository.fetchWorksaceID() // Realm에서 workspaceID 가져오기
                guard let workspaceID = workspaceID else {
                    print("⚠️ Workspace ID not found in Realm")
                    return nil
                }
                print("⚠️ \(workspaceID)⚠️ ")
                return HomeDefaultViewReactor.Action.channelSelected(
                    id: ChannelParameter(channelID: channel.channel_id, workspaceID: workspaceID)
                )
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindNavigationBar(_ navigationBar: WorkspaceCustomNavigationBar) {
        guard let reactor = self.reactor else {
            print("⚠️ Reactor is nil. NavigationBar binding skipped.")
            return
        }
        
        navigationBar.workspaceImageTapped
            .map { HomeDefaultViewReactor.Action.clickWorkspaceList }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: HomeDefaultViewReactor) {
    
        // 이 updateChannelTableViewHeight 가 왜 중복 호출해야지만 레이아웃이 제대로 잡히는지에 대해서 공부해보기!! 🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀
        
        reactor.state.map { $0.channelData }
        //            .distinctUntilChanged()
            .bind(with: self) { owner, _ in
                owner.rootView.updateChannelTableViewHeight()
                //                owner.rootView.layoutIfNeeded()
            }
            .disposed(by: disposeBag)
        
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
            .map { $0.isWorkspaceListEnabled }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { owner, _ in
//                owner.navigationController?.changePresentViewController(CreateWorkspaceViewController())
                owner.navigationController?.pushViewController(WorkspaceListViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.seletedChannel }
            .distinctUntilChanged { old, new in
                old?.channelID == new?.channelID
            }
            .compactMap{ $0 }
            .bind(with: self) { owner, channel in
                print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️\(channel)")
                let vc = ChannelChattingViewController(channelId: channel.channelID, workspaceId: channel.workspaceID)
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}

