//
//  HomeEmptyViewController.swift
//  Sparkle
//
//  Created by 최민경 on 11/9/24.
//

import UIKit

import RxSwift
import SnapKit
import ReactorKit

final class HomeEmptyViewController: BaseViewController<HomeEmptyView> {
    
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeEmptyViewController")
        self.reactor = HomeViewReactor()
    }  
}

extension HomeEmptyViewController: View {
    
    func bind(reactor: HomeViewReactor) {
        bindAction(reactor)
        bindSate(reactor)
        
    }
    
    private func bindAction(_ reactor: HomeViewReactor) {
        rootView.homeView.createWorkspaceButton.rx.tap
            .map { HomeViewReactor.Action.createWorkspace }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindSate(_ reactor: HomeViewReactor) {
        reactor.state.map { $0.shouldNavigateToNextScreen }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { owner, _ in
                print("여기")
                owner.navigationController?.changePresentViewController(CreateWorkspaceViewController())
            }
            .disposed(by: disposeBag)
    }
}
