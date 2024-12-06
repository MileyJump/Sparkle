//
//  HomeViewController.swift
//  Sparkle
//
//  Created by 최민경 on 10/30/24.
//

import UIKit

import ReactorKit
import RxSwift

final class workspaceInitialViewController: BaseViewController<workspaceInitialView>, View {
    
//    private let reactor = HomeViewReactor()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = HomeViewReactor()
//        bind(reactor: reactor)
    }
    
    override func setupNavigationBar() {
        navigationItem.title = "시작하기"
        
        let xmarkBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = xmarkBarButtonItem
        xmarkBarButtonItem.tintColor = UIColor.sparkleTextPrimaryColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = .lightGray
        appearance.backgroundColor = UIColor.secondarySystemBackground
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
//        xmarkBarButtonItem.rx.tap
//            .map { HomeViewReactor.Action.xmark }
//            .bind(to: reactor.action)
//            .disposed(by: dispoase)
    }
    
    func bind(reactor: HomeViewReactor) {
        
        rootView.createWorkspaceButton.rx.tap
            .map { HomeViewReactor.Action.createWorkspace }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.shouldNavigateToNextScreen }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.navigationController?.changePresentViewController(CreateWorkspaceViewController())
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.xmarkButtomTapped }
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.navigationController?.changeRootViewController(HomeEmptyViewController())
            }
            .disposed(by: disposeBag) 
    }
}
