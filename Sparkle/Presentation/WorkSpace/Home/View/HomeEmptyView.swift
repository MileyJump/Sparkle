//
//  HomeEmptyView.swift
//  Sparkle
//
//  Created by 최민경 on 11/9/24.
//

import UIKit

final class HomeEmptyView: BaseView {
    
    let homeView = workspaceInitialView(releaseText: "워크스페이스를 찾을 수 없어요.", workspaceMessage: "관리자에게 초대를 요청하거나, 다른 이메일로 시도하거나 새로운 워크스페이스를 생성해주세요.", workspaceImage: UIImage(named: "workspace empty"))
    
    override func setupSubviews() {
        addSubview(homeView)
    }
    
    override func setupLayout() {
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
