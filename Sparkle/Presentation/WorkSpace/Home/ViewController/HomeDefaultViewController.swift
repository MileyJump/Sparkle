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
        bind(reactor: reactor)
        if let workspaceId {
            reactor.action.onNext(.fetchChannelData(workspaceID: workspaceId))
            reactor.action.onNext(.fetchDMsData(workspaceID: workspaceId))
        }
    }
    
    override func setupUI() {

        print("====setupUI")
        rootView.channelTableView.rowHeight = UITableView.automaticDimension
        rootView.channelTableView.estimatedRowHeight = 44
        rootView.channelTableView.separatorStyle = .none // 선택사항
        rootView.channelTableView.delegate = nil
        rootView.channelTableView.dataSource = nil
//
//        rootView.directTableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWill============")
//        channelNetworkRequest()
        self.reactor = HomeDefaultViewReactor()
    }
    
    override func setupUI() {
        rootView.channelTableView.rowHeight = UITableView.automaticDimension
        rootView.channelTableView.estimatedRowHeight = 44
        rootView.channelTableView.separatorStyle = .none
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        rootView.updateDirectTableViewHeight()
    }
}


extension HomeDefaultViewController: View {
    
     func bind(reactor: HomeDefaultViewReactor) {
         
         Observable.just(workspaceId)
             .compactMap { $0 }
             .map { HomeDefaultViewReactor.Action.fetchChannelData(workspaceID: $0) }
             .bind(to: reactor.action)
             .disposed(by: disposeBag)
         
        rootView.addChannelButton.rx.tap
            .map { HomeDefaultViewReactor.Action.addChannelsButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.channelData }
            .bind(with: self) { owner, _ in
                owner.rootView.updateChannelTableViewHeight()
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
            .do(onNext: { response in
                print("데이터 방출 11Dtat updated: \(response.count) Channels")
            })
            .bind(to: rootView.channelTableView.rx.items(cellIdentifier: ChannelsTableViewCell.identifier,
                                                         cellType: ChannelsTableViewCell.self)) { (row, channel, cell) in
                print("DEBUG: 셀 바인딩 시도 - 행: \(row), 채널: \(channel)")
                cell.bind(channel: channel)
                self.rootView.updateChannelTableViewHeight()
            }
                                                         .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.dmsData }
            .asObservable()
            .bind(to: rootView.directTableView.rx.items(cellIdentifier: UserTableViewCell.identifier, cellType: UserTableViewCell.self)) { (row, dm, cell) in
                
                print("DEBUG: 셀 바인딩 시도 - 행: \(row), 채널: \(dm)")
                cell.bind(dms: dm)
                
            }
                                                        .disposed(by: disposeBag)
    }
}

