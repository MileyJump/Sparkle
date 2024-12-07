//
//  EmailLoginViewController.swift
//  Sparkle
//
//  Created by 최민경 on 11/24/24.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

final class EmailLoginViewController: BaseViewController<EmailLoginView>, View {
    
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = EmailLoginViewReactor()
//        bind(reactor: reactor)
    }
    
    override func setupUI() {
        view.backgroundColor = UIColor.sparkleBackgroundPrimaryColor
    }
    
    override func setupNavigationBar() {
        navigationItem.title = "이메일 로그인"
    }
    
     func bind(reactor: EmailLoginViewReactor) {
        
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
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .subscribe(with: self) { owner, isLoading in
                isLoading ? owner.showLoadingIndicator() : owner.hideLoadingIndicator()
            }
            .disposed(by: disposeBag)
           
//        reactor.state.filter { $0.isLoginSuccessful }
//            .map { $0.setWorkspaceCheck }
//
//            .subscribe(with: self) { owner, workspaceList in
//                print("================================\(workspaceList)============")
//                if workspaceList.isEmpty {
//                    owner.navigationController?.changeRootViewController(HomeEmptyViewController())
//                } else {
//                    owner.navigationController?.changeRootViewController(HomeDefaultViewController(workspaceId: workspaceList.first?.workspace_id))
//                }
//            }
//            .disposed(by: disposeBag)
         
        
//         1. performWorkspaceCheck가 완료되면 workspaceList를 업데이트하고, 그 후 화면 전환이 이루어지도록 처리
        Observable.combineLatest(
            reactor.state.filter { $0.isLoginSuccessful },
            reactor.state.map { $0.setWorkspaceCheck }
        )
//        .filter { !$0.1.isEmpty } // workspaceList가 비어 있지 않다면
        .subscribe(onNext: { [weak self] (isLoginSuccessful, workspaceList) in
            guard let self = self else { return }
            
            print("Login Successful: \(isLoginSuccessful), Workspace List: \(workspaceList)")
            
            if workspaceList.isEmpty {
                self.navigationController?.changeRootViewController(HomeEmptyViewController())
            } else {
                self.navigationController?.changeRootViewController(HomeDefaultViewController(workspaceId: workspaceList.first?.workspace_id))
            }
        })
        .disposed(by: disposeBag)
        
    }
    
    
    private func showLoadingIndicator() {
          // 로딩 인디케이터 표시 🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀
      }

      private func hideLoadingIndicator() {
          // 로딩 인디케이터 숨기기 🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀🍎🍀
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
