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
        print("login Funtion")
        let email = rootView.emailTextField.text ?? ""
        let password = rootView.passwordTextField.text ?? ""
        let deviceToken = DeviceToken.deviceToken
        print(email, password)
        UserNetworkManager.shared.login(query: LoginQuery(email: email, password: password, deviceToken: deviceToken))
            .subscribe { response in
                if let token = response.token?.accessToken {
                    UserDefaultsManager.shared.token = token
                    print(UserDefaultsManager.shared.token)
                }
                
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
    
}
