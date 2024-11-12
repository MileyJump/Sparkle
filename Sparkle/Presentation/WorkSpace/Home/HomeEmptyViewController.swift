//
//  HomeEmptyViewController.swift
//  Sparkle
//
//  Created by 최민경 on 11/9/24.
//

import UIKit

import RxSwift
import SnapKit

final class HomeEmptyViewController: BaseViewController<HomeEmptyView> {
    
    private let dispoaseBag = DisposeBag()
    private let reactor = HomeViewReactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeEmptyViewController")
        bind(reactor: reactor)
    }
    
    override func setupNavigationBar() {
        
        let navigationBar = WorkspaceCustomNavigationBar(workspaceImageName: "테스트 사진", title: "No Workspace", profileImageName: "테스트 사진")
        
        navigationItem.titleView = navigationBar
    }
    
    private func bind(reactor: HomeViewReactor) {
        
        rootView.homeView.createWorkspaceButton.rx.tap
            .map { HomeViewReactor.Action.createWorkspace }
            .bind(to: reactor.action)
            .disposed(by: dispoaseBag)
        
        reactor.state.map { $0.shouldNavigateToNextScreen }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { owner, _ in
                print("여기")
                owner.navigationController?.changePresentViewController(CreateWorkspaceViewController())
            }
            .disposed(by: dispoaseBag)
    }
}
