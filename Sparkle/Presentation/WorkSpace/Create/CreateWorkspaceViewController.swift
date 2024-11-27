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
            .bind(with: self) { owner, _ in
                owner.createWorkspace()
//                WorkspaceNetworkManager.shared.createWorkspace(query: CreateWorkspaceQuery(name: owner.rootView.workspaceNameTextField.text ?? "실패", description: owner.rootView.workspaceExplanationTextField.text ?? "실패2", image: ""))
//                owner.navigationController?.changeRootViewController(HomeDefaultViewController())
            }
            .disposed(by: dispoaseBag)
        
        navigationItem.leftBarButtonItem?.rx.tap
            .map { CreateWorkspaceViewReactor.Action.backButton }
            .bind(to: reactor.action)
            .disposed(by: dispoaseBag)
        
        reactor.state.map { $0.backButtonTappedState }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: dispoaseBag)
    }
    
    private func createWorkspace() {
        WorkspaceNetworkManager.shared.createWorkspace(query: CreateWorkspaceQuery(name: rootView.workspaceNameTextField.text ?? "실패", description: rootView.workspaceExplanationTextField.text ?? "실패2", image: ""))
            .subscribe(onSuccess: { response in
                // 성공 시 처리
                print("워크스페이스 생성 성공: \(response)")
                self.navigationController?.changeRootViewController(HomeDefaultViewController())
            }, onError: { error in
                // 실패 시 처리
                print("워크스페이스 생성 실패: \(error)")
            })
            .disposed(by: dispoaseBag)
    }
    
    
}
