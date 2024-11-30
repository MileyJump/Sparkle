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
    
    private let reactor = HomeDefaultViewReactor()
    private let disposeBag = DisposeBag()
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
        
        bind(reactor: reactor)
        if let workspaceId {
            reactor.action.onNext(.fetchChannelData(workspaceID: workspaceId))
        }
    }
    
    override func setupUI() {
//        rootView.channelTableView.delegate = nil
//        rootView.channelTableView.dataSource = nil
        print("====setupUI")
        rootView.channelTableView.rowHeight = UITableView.automaticDimension
        rootView.channelTableView.estimatedRowHeight = 44
        rootView.channelTableView.separatorStyle = .none // 선택사항
        
        rootView.channelTableView.register(ChannelsTableViewCell.self, forCellReuseIdentifier: ChannelsTableViewCell.identifier)
        
//        rootView.directTableView.delegate = self
//        rootView.directTableView.dataSource = self
        rootView.directTableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWill")
//        channelNetworkRequest()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // 테이블뷰 높이 업데이트
//        rootView.updateChannelTableViewHeight()
        rootView.updateDirectTableViewHeight()
    }
    
//    private func channelNetworkRequest() {
//        if let workspaceId {
//            
//            ChannelsNetworkManager.shared.myChannelCheck(parameters: WorkspaceIDParameter(workspaceID: workspaceId))
//                .subscribe(with: self) { owner, response in
//                    print(response)
//                } onFailure: { owner, error in
//                    print("에러 입니다!~~~!\(error)")
//                }
//                .disposed(by: disposeBag)
//        }
//    }
    
    private func dmsNetworkRequest() {
        
    }
    
    private func bind(reactor: HomeDefaultViewReactor) {
        rootView.addChannelButton.rx.tap
            .map { HomeDefaultViewReactor.Action.addChannelsButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.channelData }
//            .distinctUntilChanged()
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
        
        let testData = [ChannelResponse(channel_id: "d083709a-0885-4179-9878-706e65f50e1b", name: "일반", description: "", coverImage: "ㅇ", owner_id: "b0365afe-a99d-4d3b-ab7d-4897c3aed288", createdAt: "create")]

       
        
        reactor.state
            .map({ $0.channelData })
            .do(onNext: { response in
                print("Dtat updated: \(response) Channels")
            })
            .filter{ !$0.isEmpty }
            .observe(on: MainScheduler.instance)
            .bind(to: rootView.channelTableView.rx.items (cellIdentifier: ChannelsTableViewCell.identifier, cellType: ChannelsTableViewCell.self)) { [weak self] row, channel, cell in
                print("DEBUG: 셀 바인딩 - 행: \(row), 채널: \(channel)")
                cell.bind(channel: channel)
                self?.rootView.updateChannelTableViewHeight()
                print("음??")
            }
            .disposed(by: disposeBag)
    }
}

//extension HomeDefaultViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == rootView.channelTableView {
//            return 5
//        } else {
//            return 2
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == rootView.channelTableView {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelsTableViewCell.identifier, for: indexPath) as? ChannelsTableViewCell else { return UITableViewCell() }
//            return cell
//        } else {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
//            return cell
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 41
//    }
//    
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//   
//        rootView.updateChannelTableViewHeight()
//        rootView.updateDirectTableViewHeight()
//        
//    }
//}
