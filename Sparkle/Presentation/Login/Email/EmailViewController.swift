//
//  EmailLoginViewController.swift
//  Sparkle
//
//  Created by 최민경 on 11/24/24.
//

import UIKit

import RxSwift

final class EmailLoginViewController: BaseViewController<EmailLoginView> {
    
    private let reactor = EmailLoginViewReactor()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(reactor: reactor)
    }
    
    override func setupUI() {
        view.backgroundColor = UIColor.sparkleBackgroundPrimaryColor
    }
    
    override func setupNavigationBar() {
        navigationItem.title = "이메일 로그인"
    }
    
    private func bind(reactor: EmailLoginViewReactor) {
        
        rootView.emailTextField.rx.text.orEmpty
            .map { EmailLoginViewReactor.Action.updateEmail($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        rootView.passwordTextField.rx.text.orEmpty
            .map { EmailLoginViewReactor.Action.updatePassword($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        rootView.confirmButton.rx.tap
            .map { EmailLoginViewReactor.Action.comfirmButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        reactor.state.map { $0.isEmailValid }
            .map { $0 ? "" : "이메일 형식이 올바르지 않습니다." }
            .bind(to: rootView.emailValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isPasswordValid }
            .map { $0 ? "" : "비밀번호는 최소 8자 이상, 하나 이상의 대소문자/숫자/특수 문자를 설정해주세요." }
            .bind(to: rootView.passwordValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isConfirmEnabled }
            .bind(to: rootView.confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isConfirmEnabled }
            .map { $0 ? UIColor.sparkleBrandOrangeColor : UIColor.sparkleBrandInactiveColor }
            .subscribe(with: self, onNext: { owner, color in
                owner.rootView.confirmButton.updateBackgroundColor(color)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isConfirmButton }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.login()
            }
            .disposed(by: disposeBag)
    }
    
    private func login() {
        
        guard let email = rootView.emailTextField.text, !email.isEmpty else {
            return
        }
        guard let password = rootView.passwordTextField.text, !password.isEmpty else {
            return
        }
        let deviceToken = DeviceToken.deviceToken
        
        // Reactor로 바꿔야 됨
        UserNetworkManager.shared.login(query: LoginQuery(email: email, password: password, deviceToken: deviceToken))
            .subscribe(with: self) { owner, response in
                if let token = response.token?.accessToken {
                    
                    UserDefaultsManager.shared.token = token
                    owner.handleLoginSuccess()
                }
            } onFailure: { owner, error in
                
                owner.handleLoginError(error: error)
            }
            .disposed(by: disposeBag)
    }
    
 
    private func handleLoginSuccess() {
        navigationController?.changeRootViewController(HomeEmptyViewController())
    }
    
    private func handleLoginError(error: Error) {
        showAlert(message: "로그인에 실패했습니다. 다시 시도해주세요.")
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
