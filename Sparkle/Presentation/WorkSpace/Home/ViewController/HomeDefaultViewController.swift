//
//  HomeDefaultViewController.swift
//  Sparkle
//
//  Created by 최민경 on 11/22/24.
//

import UIKit

import ReactorKit
import RxSwift

final class HomeDefaultViewController: BaseViewController<HomeDefaultView> {
    
    private let reactor = HomeDefaultViewReactor()
    private let dispoase = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(reactor: reactor)
    }
    
    override func setupUI() {
        rootView.channelTableView.delegate = self
        rootView.channelTableView.dataSource = self
        rootView.channelTableView.register(ChannelsTableViewCell.self, forCellReuseIdentifier: ChannelsTableViewCell.identifier)
        
        rootView.directTableView.delegate = self
        rootView.directTableView.dataSource = self
        rootView.directTableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // 테이블뷰 높이 업데이트
        rootView.updateChannelTableViewHeight()
        rootView.updateDirectTableViewHeight()
    }
    
    private func bind(reactor: HomeDefaultViewReactor) {
        rootView.addChannelButton.rx.tap
            .map { HomeDefaultViewReactor.Action.addChannelsButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: dispoase)
        
        reactor.state.map { $0.createWorkspace }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.navigationController?.changePresentViewController(CreateWorkspaceViewController())
            }
            .disposed(by: dispoase)
    }
}

extension HomeDefaultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == rootView.channelTableView {
            return 5
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == rootView.channelTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelsTableViewCell.identifier, for: indexPath) as? ChannelsTableViewCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 41
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
   
        rootView.updateChannelTableViewHeight()
        rootView.updateDirectTableViewHeight()
        
    }
}
