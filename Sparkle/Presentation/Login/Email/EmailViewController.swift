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
        
        rootView.confirmButton.rx.tap
            .map { EmailLoginViewReactor.Action.comfirmButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.comfirmButtonTapped }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.login()
            }
            .disposed(by: disposeBag)
    }
    
    private func login() {

        guard let email = rootView.emailTextField.text, !email.isEmpty else {
            showAlert(message: "이메일을 입력해주세요.")
            return
        }
        guard let password = rootView.passwordTextField.text, !password.isEmpty else {
            showAlert(message: "비밀번호를 입력해주세요.")
            return
        }
        let deviceToken = DeviceToken.deviceToken
        
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
