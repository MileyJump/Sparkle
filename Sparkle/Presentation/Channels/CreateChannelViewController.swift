////
////  CreateChannelViewController.swift
////  Sparkle
////
////  Created by 최민경 on 12/27/24.
////
//
//import UIKit
//
//import RxSwift
//
//final class CreateChannelViewController: BaseViewController<CreateChannelView> {
//    
//    private let disposeBag = DisposeBag()
//    private let reactor = CreateWorkspaceViewReactor()
//    private let imagePicker = UIImagePickerController()
//    let tapGesture = UITapGestureRecognizer()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        
//        bind(reactor: reactor)
//    }
//    
//    override func setupNavigationBar() {
//        navigationItem.title = "채널 생성"
//    }
//    
//    
//    
//    private func bind(reactor: CreateWorkspaceViewReactor) {
//        
//        
//    }
//
//    
//    
//    private func createWorkspace() {
//        
//        guard let name = rootView.workspaceNameTextField.text, !name.isEmpty else {
//            return
//        }
//         let description = rootView.workspaceExplanationTextField.text ?? ""
//        
//        guard let selectedImage = reactor.currentState.selectedImage else {
//            return
//        }
//        
//        guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
//            return
//        }
//        print("=====네임 : \(name) // description \(description) // image !! \(imageData)===")
//            WorkspaceNetworkManager.shared.createWorkspace(query: CreateWorkspaceQuery(name: name, description: description, image: imageData))
//                .subscribe(with: self) { owner, response in
//                    print("성공!! ===== \(response)")
//                    owner.HomeDefaultView()
//                } onFailure: { owner, error in
//                    print("에러입니다!!!! \(error)")
//                }
//                .disposed(by: disposeBag)
//    }
//    
//    private func HomeDefaultView() {
//        let vc = HomeDefaultViewController()
//        navigationController?.changeRootViewController(vc)
//    }
//}
//
//extension CreateWorkspaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        if let selectedImage = info[.originalImage] as? UIImage {
//            print("Selected image: \(selectedImage)")
//            reactor.action.onNext(.selectImage(selectedImage))
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//}
//
//}
