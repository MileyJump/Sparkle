//
//  HomeViewController.swift
//  Sparkle
//
//  Created by 최민경 on 10/30/24.
//

import UIKit

import ReactorKit
import RxSwift

final class HomeViewController: BaseViewController<HomeView> {
    
    private let reactor = HomeViewReactor()
    private let dispoase = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bint(reactor: reactor)
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
        
        xmarkBarButtonItem.rx.tap
            .map { HomeViewReactor.Action.xmark }
            .bind(to: reactor.action)
            .disposed(by: dispoase)
    }
    
    private func bint(reactor: HomeViewReactor) {
        
        rootView.createWorkspaceButton.rx.tap
            .map { HomeViewReactor.Action.createWorkspace }
            .bind(to: reactor.action)
            .disposed(by: dispoase)
        
        reactor.state.map { $0.shouldNavigateToNextScreen }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.createWorkspace()
            }
            .disposed(by: dispoase)
        
        reactor.state.map { $0.xmarkButtomTapped }
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.homeView()
            }
            .disposed(by: dispoase)
            
    }
    
    private func createWorkspace() {
        let createVC = CreateWorkspaceViewController()
        let navi = UINavigationController(rootViewController: createVC)
        navigationController?.present(navi, animated: true)
    }
    
    private func homeView() {
        let createVC = HomeEmptyViewController()
        let navi = UINavigationController(rootViewController: createVC)
        navigationController?.present(navi, animated: true)
    }
}
