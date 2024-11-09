//
//  CreateWorkspaceViewController.swift
//  Sparkle
//
//  Created by 최민경 on 11/8/24.
//

import UIKit

final class CreateWorkspaceViewController: BaseViewController<CreateWorkspaceView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTitleAndImage(title: "워크스페이스 생성", imageName: "xmark")
    }
    
    override func setupUI() {
        view.backgroundColor = UIColor.sparkleBackgroundPrimaryColor
    }
}
