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
    
    private func emailLoginVC() {
        navigationController?.pushViewController(EmailLoginViewController(), animated: true)
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
        
        rootView.emailLoginButton.rx.tap
            .map { LoginViewReactor.Action.emailLoginButtonTapped }
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
       
        reactor.state
            .map { $0.isEamilLogin }
            .distinctUntilChanged()
        
            .bind(with: self) {  owner, isPresented in
                if isPresented {
                    let loginViewController = EmailLoginViewController()
                    
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

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        
        print(credential.user)
        
        reactor?.action.onNext(.appleLoginSuccess(credential.user))
    }

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        print("Apple login failed: \(error.localizedDescription)")
        
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
        controller.delegate = self
        controller.performRequests()
    }
}
