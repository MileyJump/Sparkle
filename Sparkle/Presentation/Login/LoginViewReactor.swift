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

class LoginViewReactor: Reactor {
    
    enum Action {
        case kakaoLoginButtonTapped
        case appleLoginButtonTapped
        case emailLoginButtonTapped
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setLoginSuccess(Bool)
        case setErrorMessage(String?)
        
    }
    
    struct State {
        var isLoading: Bool = false
        var isLoginSuccess: Bool = false
        var errorMessage: String? = nil
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .kakaoLoginButtonTapped:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                kakaoLogin(),
                Observable.just(.setLoading(false))
            ])
        case .appleLoginButtonTapped:
            return Observable.just(.setLoading(true))
        case .emailLoginButtonTapped:
            return Observable.just(.setLoading(true))
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
    
    
    
    
    private func kakaoLoginWithApp() {
        
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print("KakaoTalk login error: \(error)")
            }
            else {
                print("loginWithKakaoTalk() success.")
                
                //do something
                _ = oauthToken
            }
        }
    }
    
    func kakaoLoginWithAccount() {
        
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
            }
        }
    }
    
    //    func KakaoLogin() {
    //        // 카카오톡 실행 가능 여부 확인
    //        if (UserApi.isKakaoTalkLoginAvailable()) {
    //            // 카카오톡 앱으로 로그인 인증
    //            kakaoLoginWithApp()
    //        } else { // 카톡이 설치가 안 되어 있을 때
    //            // 카카오 계정으로 로그인
    //            kakaoLoginWithAccount()
    //        }
    //    }
    
    //    private func kakaoLogin() -> Observable<Bool> {
    //        return Observable<Bool>.create { observer in
    //            if UserApi.isKakaoTalkLoginAvailable() {
    //                UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
    //                    if let error = error {
    //                        print(error)
    //                        observer.onNext(false)
    //                    } else {
    //                        observer.onNext(true)
    //                    }
    ////                        else {
    ////                        self?.setUserInfo()
    ////                    }
    //                    observer.onCompleted()
    //                }
    //            } else {
    //                UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
    //                    if let error = error {
    //                        print(error)
    //                        observer.onNext(false)
    //                    } else {
    //                        observer.onNext(true)
    ////                        self?.setUserInfo()
    //                    }
    //                    observer.onCompleted()
    //                }
    //            }
    //            return Disposables.create()
    //        }
    //    }
    
    //    private func setUserInfo() {
    //        UserApi.shared.me { [weak self] (user, error) in
    //            if let error = error {
    //                print(error)
    //            } else {
    //                guard let self = self else { return }
    //                guard let userId = user?.id else {return}
    //                guard let email = user?.kakaoAccount?.email else { return }
    //                guard let profileImage = user?.kakaoAccount?.profile?.profileImageUrl else { return }
    //                guard let nickname = user?.kakaoAccount?.profile?.nickname else { return }
    //
    //                print(email)
    //                print(profileImage)
    //                print(nickname)
    //            }
    //
    //        }
    //
    //
    //    }
    //}
}
