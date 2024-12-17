//
//  WorkspaceListViewController.swift
//  Sparkle
//
//  Created by 최민경 on 12/16/24.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

final class WorkspaceListViewController: BaseViewController<WorkspaceListView> {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = WorkspaceListViewReactor()
    }
}

extension WorkspaceListViewController: View {
    
    func bind(reactor: WorkspaceListViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: WorkspaceListViewReactor) {
        reactor.action.onNext(.fetchInitialChats)
    }
    
    private func bindState(_ reactor: WorkspaceListViewReactor) {
        reactor.state
            .map { $0.workspaceList }
            .asObservable()
            .bind(to: rootView.workspaceTableView.rx.items(cellIdentifier: WorkspaceListTableViewCell.identifier, cellType: WorkspaceListTableViewCell.self)) { (row, list, cell) in
                
            }
            .disposed(by: disposeBag)
    }
}
