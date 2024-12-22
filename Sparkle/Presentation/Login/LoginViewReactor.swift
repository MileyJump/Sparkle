//
//  LoginViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 12/18/24.
//

import UIKit

import ReactorKit
import RealmSwift

import KakaoSDKAuth
import KakaoSDKUser

import AuthenticationServices

class LoginViewReactor: Reactor {
    
    enum Action {
        case kakaoLoginButtonTapped
        case appleLoginButtonTapped
        case emailLoginButtonTapped
        case appleLoginSuccess(String) // Apple 로그인 성공 처리
        case appleLoginFailure(String)
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setLoginSuccess(Bool)
        case setErrorMessage(String?)
        case setEmailLogin(Bool)
        
    }
    
    struct State {
        var isLoading: Bool = false
        var isLoginSuccess: Bool = false
        var errorMessage: String? = nil
        var isEamilLogin: Bool = false
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .appleLoginButtonTapped:
            return Observable.just(.setLoading(true))
            
        case .appleLoginSuccess:
            return Observable.just(.setLoginSuccess(true))
            
        case .appleLoginFailure(let errorMessage):
            return Observable.just(.setErrorMessage(errorMessage))
            
        case .emailLoginButtonTapped:
            return Observable.concat([
                Observable.just(.setEmailLogin(true)),
                Observable.just(.setEmailLogin(false))
            ])
            
            
            
            
        case .kakaoLoginButtonTapped:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                kakaoLogin(),
                Observable.just(.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .setLoginSuccess(let isSuccess):
            newState.isLoginSuccess = isSuccess
        case .setErrorMessage(let message):
            newState.errorMessage = message
        case .setEmailLogin(let login):
            newState.isEamilLogin = login
        }
        return newState
    }
    
    private func kakaoLogin() -> Observable<Mutation> {
        return Observable.create { observer in
            // 카카오톡 실행 가능 여부 확인
            if UserApi.isKakaoTalkLoginAvailable() {
                // 카카오톡 앱으로 로그인 인증
                UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                    if let error = error {
                        print("KakaoTalk login error: \(error)")
                        observer.onNext(.setErrorMessage(error.localizedDescription))
                        observer.onNext(.setLoginSuccess(false))
                    } else {
                        print("KakaoTalk login success.")
                        observer.onNext(.setLoginSuccess(true))
                    }
                    observer.onCompleted()
                }
            } else {
                // 카카오 계정으로 로그인
                UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                    if let error = error {
                        print("KakaoAccount login error: \(error)")
                        observer.onNext(.setErrorMessage(error.localizedDescription))
                        observer.onNext(.setLoginSuccess(false))
                    } else {
                        print("KakaoAccount login success.")
                        observer.onNext(.setLoginSuccess(true))
                    }
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
}
