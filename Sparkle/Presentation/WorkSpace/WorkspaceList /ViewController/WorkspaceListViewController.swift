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
        
        rootView.workspaceTableView.rowHeight = 70
        
        navigationItem.title = "워크스페이스"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)

           self.tabBarController?.tabBar.isHidden = true
       }
    
    override func viewWillDisappear(_ animated: Bool) {
      
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func setupNavigationBar() {
        navigationItem.title = "워크스페이스"
            
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.prefersLargeTitles = true
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
                cell.bind(list)
            }
            .disposed(by: disposeBag)
    }
}
