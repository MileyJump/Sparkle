//
//  LoginViewController.swift
//  Sparkle
//
//  Created by 최민경 on 12/18/24.
//
import UIKit
import AuthenticationServices
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
        
        rootView.appleLoginButton.rx.tap
            .map { LoginViewReactor.Action.appleLoginButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    
    private func bindState(_ reactor: LoginViewReactor) {
        reactor.state
            .map { $0.isLoading }
            .distinctUntilChanged()
            .subscribe { isLoading in
                
            }
            .disposed(by: disposeBag)
       
    }
    
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    // Apple 로그인 성공 시 리액터에 결과 전달
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        
        print(credential.user)
        
        // 리액터에 Apple 로그인 성공 액션 전달
        reactor?.action.onNext(.appleLoginSuccess(credential.user))
    }

    // Apple 로그인 실패 시 리액터에 결과 전달
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        print("Apple login failed: \(error.localizedDescription)")
        
        // 리액터에 Apple 로그인 실패 액션 전달
        reactor?.action.onNext(.appleLoginFailure(error.localizedDescription))
    }
}

extension LoginViewController {
    
    // Apple 로그인 요청 함수
    func appleLogin() {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self  // 여기서 delegate를 self로 설정
        controller.performRequests()
    }
}
