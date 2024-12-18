//
//  LoginViewController.swift
//  Sparkle
//
//  Created by 최민경 on 12/18/24.
//

import ReactorKit

final class LoginViewController: BaseViewController<LoginView> {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = LoginViewReactor()
    }
    
}


extension LoginViewController: View {
    
    func bind(reactor: LoginViewReactor) {
        bindAction(reactor)
        bindState(reactor)
       
    }
    
    private func bindAction(_ reactor: LoginViewReactor) {
        
        rootView.kakaoLoginButton.rx.tap
            .map { LoginViewReactor.Action.kakaoLoginButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    
    private func bindState(_ reactor: LoginViewReactor) {
        
        reactor.state
            .map { $0.isLoginSuccess }
            .distinctUntilChanged()
            .bind(with: self) { owner, isLoading in
                print("🛍️🛍️🛍️🛍️ \(isLoading)")
            }
            .disposed(by: disposeBag)
    }
    
}
