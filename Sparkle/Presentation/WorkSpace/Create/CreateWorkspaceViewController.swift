//
//  CreateWorkspaceViewController.swift
//  Sparkle
//
//  Created by 최민경 on 11/8/24.
//

import UIKit

import RxSwift

final class CreateWorkspaceViewController: BaseViewController<CreateWorkspaceView> {
    
    private let dispoaseBag = DisposeBag()
    private let reactor = CreateWorkspaceViewReactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarTitleAndImage(title: "워크스페이스 생성", imageName: "xmark")
        
        bind(reactor: reactor)
    }
    
    override func setupUI() {
        view.backgroundColor = UIColor.sparkleBackgroundPrimaryColor
    }
    
    private func bind(reactor: CreateWorkspaceViewReactor) {
        
        rootView.confirmButton.rx.tap
            .map { CreateWorkspaceViewReactor.Action.comfirmButton }
            .bind(to: reactor.action)
            .disposed(by: dispoaseBag)
        
        reactor.state.map { $0.comfirmButtonTapped }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { onwer, _ in
                onwer.navigationController?.changeRootViewController(HomeInitialViewController())
            }
            .disposed(by: dispoaseBag)
    }
}
