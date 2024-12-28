//
//  ChannelSearchView.swift
//  Sparkle
//
//  Created by 최민경 on 12/15/24.
//

import UIKit

import Then
import SnapKit

final class ChannelSearchView: BaseView {
    
    let searchBar = UISearchBar().then {
        $0.placeholder = "채널을 검색해보세요."
    }
    
    let searchTableView = UITableView().then {
        $0.register(ChannelSearchTableViewCell.self, forCellReuseIdentifier: ChannelSearchTableViewCell.identifier)
        $0.separatorStyle = .none
        $0.allowsSelection = false
//        $0.backgroundColor = .green
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(searchTableView)
        addSubview(searchBar)
    }
    
    override func setupLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
            
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}
