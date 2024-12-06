//
//  EmailViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 11/24/24.
//

import ReactorKit

import RxSwift
import RxCocoa
import Foundation

final class EmailLoginViewReactor: Reactor {
    
    enum Action {
        case updateEmail(String)
        case updatePassword(String)
        case comfirmButtonTapped
        case backButtonTapped
    }
    
    enum Mutation {
        case setEmail(String)
        case setPassword(String)
        case setEmailValidation(Bool)
        case setPasswordValidation(Bool)
        case setConfirmEnabled(Bool)
        case setLoading(Bool)
        case setLoginSuccess(Bool)
        case backButtonTapped(Bool)
        case setWorkspaceCheck([WorkspaceListCheckResponse])
        case setError(Error)
    }
    
    struct State {
        var email: String = ""
        var password: String = ""
        var isEmailValid: Bool = false
        var isPasswordValid: Bool = false
        var isConfirmEnabled: Bool = false
        var isLoading: Bool = false
        var isLoginSuccessful: Bool = false
        var backButtonTappedState: Bool = false
        var setWorkspaceCheck : [WorkspaceListCheckResponse] = []
        var error: Error?
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateEmail(let email):
            let isValid = validateEmail(email)
            return Observable.concat([
                Observable.just(.setEmailValidation(isValid)),
                Observable.just(.setConfirmEnabled(isValid && currentState.isPasswordValid)),
                Observable.just(.setEmail(email))
            ])
            
        case .updatePassword(let password):
            let isValid = validatePassword(password)
            return Observable.concat([
                Observable.just(.setPasswordValidation(isValid)),
                Observable.just(.setConfirmEnabled(isValid && currentState.isEmailValid)),
                Observable.just(.setPassword(password))
            ])
            
        case .comfirmButtonTapped:
            
            return Observable.concat([
                Observable.just(.setConfirmEnabled(true)),
                performLogin(email: currentState.email, password: currentState.password)
            ])
            
        case .backButtonTapped:
            return Observable.just(.backButtonTapped(true))
        }
    }
   
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setEmail(let email):
            state.email = email
        
        case .setPassword(let password):
            state.password = password
            
        case .setEmailValidation(let isValid):
            state.isEmailValid = isValid
            
        case .setPasswordValidation(let isValid):
            state.isPasswordValid = isValid
            
        case .setConfirmEnabled(let isEnabled):
            state.isConfirmEnabled = isEnabled
            
        case .setLoading(let isLoading):
            state.isLoading = isLoading
            
        case .setLoginSuccess(let isSuccessful):
            state.isLoginSuccessful = isSuccessful
            
        case .backButtonTapped(let isValid):
            state.backButtonTappedState = isValid
            
        case .setWorkspaceCheck(let workspace):
            print("🍎🍎🍎🍎🍎\(workspace)🍎🍎")
            state.setWorkspaceCheck = workspace
            
        case .setError(let error):
            state.error = error
        }
        return state
    }
    
    
    private func performLogin(email: String, password: String) -> Observable<Mutation> {
        let deviceToken = DeviceToken.deviceToken
        return UserNetworkManager.shared.login(query: LoginQuery(email: email, password: password, deviceToken: deviceToken))
            .asObservable()
            .flatMap { [weak self] response -> Observable<Mutation> in
                guard let self = self else { return Observable.empty() }
                if let token = response.token?.accessToken {
                    UserDefaultsManager.shared.token = token
                    return Observable.concat([
                        Observable.just(.setLoginSuccess(true)),
                        self.performWorkspaceCheck()
                    ])
                } else {
                    return Observable.just(.setError(NSError(domain: "LoginError", code: -1, userInfo: [NSLocalizedDescriptionKey: "로그인에 실패했습니다."])))
                }
            }
            .catch { error in
                return Observable.just(.setError(error))
            }
            .concat(Observable.just(.setLoading(false)))
    }
    
    private func performWorkspaceCheck() -> Observable<Mutation> {
        return WorkspaceNetworkManager.shared.workspacesListCheck()
            .asObservable()
            .map {
                return Mutation.setWorkspaceCheck($0)
            }
            .catch { error in
                return Observable.just(.setError(error))
            }
    }
    
     private func validateEmail(_ email: String) -> Bool {
         let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.(com|net|co\\.kr)"
         return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
     }
     
     private func validatePassword(_ password: String) -> Bool {
         let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,}$"
         return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
     }
}


