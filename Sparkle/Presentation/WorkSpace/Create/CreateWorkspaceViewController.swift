//
//  CreateWorkspaceViewController.swift
//  Sparkle
//
//  Created by 최민경 on 11/8/24.
//

import UIKit

import RxSwift

final class CreateWorkspaceViewController: BaseViewController<CreateWorkspaceView> {
    
    private let disposeBag = DisposeBag()
    private let reactor = CreateWorkspaceViewReactor()
    private let imagePicker = UIImagePickerController()
    let tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarTitleAndImage(title: "워크스페이스 생성", imageName: "xmark")
        setupProfileImagePicker()
        bind(reactor: reactor)
    }
    
    override func setupUI() {
        view.backgroundColor = UIColor.sparkleBackgroundPrimaryColor
    }
    
    private func setupProfileImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
    }
    
    private func bind(reactor: CreateWorkspaceViewReactor) {
        
        rootView.profileImageView.addGestureRecognizer(tapGesture)
        rootView.profileImageView.isUserInteractionEnabled = true
        
        tapGesture.rx.event
            .bind(with: self, onNext: { owner, _ in
                owner.present(owner.imagePicker, animated: true, completion: nil )
            })
            .disposed(by: disposeBag)
        
        rootView.confirmButton.rx.tap
            .map { CreateWorkspaceViewReactor.Action.comfirmButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem?.rx.tap
            .map { CreateWorkspaceViewReactor.Action.backButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.comfirmButtonTapped }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.createWorkspace()
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.backButtonTappedState }
            .distinctUntilChanged()
            .filter { $0 }
//            .take(1)
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.selectedImage }
            .distinctUntilChanged()
            .compactMap { $0 }
            .bind(with: self) { owner, image in
                print("=====image \(image)===")
                
                owner.rootView.profileImageView.image = image
            }
            .disposed(by: disposeBag)
    }
    
    
    private func createWorkspace() {
        
        guard let name = rootView.workspaceNameTextField.text, !name.isEmpty else {
            return
        }
         let description = rootView.workspaceExplanationTextField.text ?? ""
        
        guard let selectedImage = reactor.currentState.selectedImage else {
            return
        }
        
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
            return
        }
        print("=====네임 : \(name) // description \(description) // image !! \(imageData.count)===")
            WorkspaceNetworkManager.shared.createWorkspace(query: CreateWorkspaceQuery(name: name, description: description, image: imageData))
                .subscribe(with: self) { owner, response in
                    print("성공!! ===== \(response)")
                    owner.HomeDefaultView(workspaceID: response.workspace_id)
                } onFailure: { owner, error in
                    print("에러입니다!!!! \(error)")
                    owner.HomeDefaultView(workspaceID: "f05a5591-faab-4452-91e3-1fd8a0159a40")
                }
                .disposed(by: disposeBag)
    }
    
    private func HomeDefaultView(workspaceID: String) {
        navigationController?.changeRootViewController(HomeDefaultViewController(workspaceId: workspaceID))
    }
}

extension CreateWorkspaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            print("Selected image: \(selectedImage)")
            reactor.action.onNext(.selectImage(selectedImage))
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
