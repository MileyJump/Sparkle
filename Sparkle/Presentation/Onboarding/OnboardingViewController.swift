//
//  OnboardingViewController.swift
//  Sparkle
//
//  Created by 최민경 on 10/31/24.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa

final class OnboardingViewController: BaseViewController<OnboardingView> {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = OnboardingViewReactor()
    }
    
}

extension OnboardingViewController: View {
    
    func bind(reactor: OnboardingViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    

    private func bindAction(_ reactor: OnboardingViewReactor) {
        
        rootView.startButton.rx.tap
            .map { OnboardingViewReactor.Action.startButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: OnboardingViewReactor) {
        reactor.state
            .map { $0.isLoginViewControllerPresented }
            .distinctUntilChanged()
            .bind(with: self) { owner, isPresented in
                if isPresented {
                    let loginViewController = LoginViewController()
                    
                    if let sheet = loginViewController.sheetPresentationController {
                        sheet.detents = [
                            .custom(resolver: { context in
                                return 250
                            }),
                            .large()
                        ]
                        sheet.prefersGrabberVisible = true
                        sheet.preferredCornerRadius = 20
                    }
                    
                    owner.present(loginViewController, animated: true, completion: nil)
                }
            }
            .disposed(by: disposeBag)
    }
}
