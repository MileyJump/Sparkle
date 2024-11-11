//
//  HomeEmptyView.swift
//  Sparkle
//
//  Created by 최민경 on 11/9/24.
//

import UIKit

final class HomeEmptyView: BaseView {
    
    let homeView = HomeView(releaseText: "안녕", workspaceImage: UIImage(named: "workspace empty"))
    
    override func setupSubviews() {
        addSubview(homeView)
    }
    
    override func setupLayout() {
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
