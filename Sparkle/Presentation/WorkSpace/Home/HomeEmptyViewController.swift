//
//  HomeEmptyViewController.swift
//  Sparkle
//
//  Created by 최민경 on 11/9/24.
//

import UIKit

import SnapKit

final class HomeEmptyViewController: BaseViewController<HomeEmptyView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeEmptyViewController")
    }
    
    override func setupNavigationBar() {
        let navigationBar = WorkspaceCustomNavigationBar(workspaceImageName: "테스트 사진", title: "No Workspace", profileImageName: "테스트 사진")
        
        navigationItem.titleView = navigationBar
        
        navigationBar.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(44)
        }
    }
    
}
