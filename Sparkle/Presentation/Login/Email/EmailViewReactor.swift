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
        case setEmailValidation(Bool)
        case setPasswordValidation(Bool)
        case setConfirmEnabled(Bool)
        case setConfirmButton(Bool)
        case backButtonTapped
    }
    
    struct State {
        var isEmailValid: Bool = false
        var isPasswordValid: Bool = false
        var isConfirmEnabled: Bool = false
        var isConfirmButton: Bool = false
        var backButtonTappedState: Bool = false
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .comfirmButtonTapped:
            return Observable.concat([
                Observable.just(.setConfirmEnabled(true)),
                Observable.just(.setConfirmButton(true))
            ])
            
        case .backButtonTapped:
            return Observable.just(.backButtonTapped)
            
        case .updateEmail(let email):
            let isValid = validateEmail(email)
            return Observable.concat([
                Observable.just(.setEmailValidation(isValid)),
                Observable.just(.setConfirmEnabled(isValid && currentState.isPasswordValid))
            ])
            
        case .updatePassword(let password):
            let isValid = validatePassword(password)
            return Observable.concat([
                Observable.just(.setPasswordValidation(isValid)),
                Observable.just(.setConfirmEnabled(isValid && currentState.isEmailValid))
            ])
        }
    }
   
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .backButtonTapped:
            state.backButtonTappedState = true
            
        case .setEmailValidation(let isValid):
            state.isEmailValid = isValid
            
        case .setPasswordValidation(let isValid):
            state.isPasswordValid = isValid
            
        case .setConfirmEnabled(let isEnabled):
            state.isConfirmEnabled = isEnabled
            
        case .setConfirmButton(let isEnabled):
            state.isConfirmButton = isEnabled
        }
        return state
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


