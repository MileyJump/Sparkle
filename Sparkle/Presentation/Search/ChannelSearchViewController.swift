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
                .debounce(.milliseconds(300), scheduler: MainScheduler.instance) // 입력 디바운스 처리
                .map { Reactor.Action.searchUpdate($0) } // 검색어 업데이트 액션 생성
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: ChannelSearchViewReactor) {
//        reactor.state
//            .map { $0.channels }
//            .asObservable()
//            .bind(to: rootView.searchTableView.rx.items(cellIdentifier: ChannelSearchTableViewCell.identifier, cellType: ChannelSearchTableViewCell.self)) { row, channel, cell in
//                cell.bind(channel: channel)
//            }
//            .disposed(by: disposeBag)
        
        reactor.state
                .map { $0.filteredChannels } // 필터링된 데이터만 바인딩
                .asObservable()
                .bind(to: rootView.searchTableView.rx.items(cellIdentifier: ChannelSearchTableViewCell.identifier, cellType: ChannelSearchTableViewCell.self)) { row, channel, cell in
                    cell.bind(channel: channel)
                }
                .disposed(by: disposeBag)
            
    }
    
    
}
