//
//  CreateWorkspaceViewReactor.swift
//  Sparkle
//
//  Created by 최민경 on 11/11/24.
//
import UIKit

import ReactorKit
import RxSwift
import RxCocoa


final class CreateWorkspaceViewReactor: Reactor {
    
    enum Action {
        case comfirmButton
        case backButton
        case selectImage(UIImage)
    }
    
    enum Mutation {
        case setComfirmButtonTapped(Bool)
        case setBackButtonTapped(Bool)
        case setImage(String)
        case setSelectedImage(UIImage)
    }
    
    struct State {
        var comfirmButtonTapped: Bool = false
        var backButtonTappedState: Bool = false
        var selectedImageBase64: String = ""
        var selectedImage: UIImage? = nil
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(comfirmButtonTapped: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .comfirmButton:
            return Observable.just(.setComfirmButtonTapped(true))
            
        case .backButton:
            return Observable.just(.setBackButtonTapped(true))
            
        case .selectImage(let image):
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                return .empty()
            }
            let base64String = imageData.base64EncodedString()
            return Observable.concat([
                Observable.just(.setImage(base64String)),
                Observable.just(.setSelectedImage(image))
            ])
        }
    }
   
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setComfirmButtonTapped(let isTapped):
            state.comfirmButtonTapped = isTapped
        case .setBackButtonTapped(let isTapped):
            state.backButtonTappedState = isTapped
        case .setImage(let base64String):
            state.selectedImageBase64 = base64String
        case .setSelectedImage(let image):
            state.selectedImage = image
        }
        return state
    }
}


