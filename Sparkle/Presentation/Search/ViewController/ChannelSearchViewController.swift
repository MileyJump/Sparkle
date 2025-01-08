//
//  ChannelSearchViewController.swift
//  Sparkle
//
//  Created by 최민경 on 12/15/24.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

final class ChannelSearchViewController: BaseViewController<ChannelSearchView> {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = ChannelSearchViewReactor()
        reactor?.action.onNext(.fetchInitialWorkspace)
    }
    
    override func setupNavigationBar() {
        navigationItem.title = "채널 탐색"
    }
}

extension ChannelSearchViewController: View {
    
    func bind(reactor: ChannelSearchViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    
    private func bindAction(_ reactor: ChannelSearchViewReactor) {
        rootView.searchBar.rx.text
                .orEmpty
                .distinctUntilChanged()
                .debounce(.milliseconds(300), scheduler: MainScheduler.instance) // 시간이 지난 후에 마지막으로 발생한 이벤트만 처리
                .map { Reactor.Action.searchUpdate($0) }
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: ChannelSearchViewReactor) {
        
        reactor.state
                .map { $0.filteredChannels }
                .asObservable()
                .bind(to: rootView.searchTableView.rx.items(cellIdentifier: ChannelSearchTableViewCell.identifier, cellType: ChannelSearchTableViewCell.self)) { row, channel, cell in
                    cell.bind(channel: channel)
                }
                .disposed(by: disposeBag)
    }
}
