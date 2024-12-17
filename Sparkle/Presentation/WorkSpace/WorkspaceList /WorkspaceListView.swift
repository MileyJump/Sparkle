//
//  WorkspaceListView.swift
//  Sparkle
//
//  Created by 최민경 on 12/16/24.
//

import UIKit

import Then
import SnapKit

final class WorkspaceListView: BaseView {
    
    let workspaceTableView = UITableView().then {
        $0.register(WorkspaceListTableViewCell.self, forCellReuseIdentifier: WorkspaceListTableViewCell.identifier)
        $0.separatorStyle = .none
        $0.allowsSelection = false
        $0.backgroundColor = .blue
    }
    
    private let workspaceAddButton = AddButton(title: "워크스페이스 추가", image:  UIImage(systemName: "plus"))
 
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(workspaceTableView)
        addSubview(workspaceAddButton)
    }
    
    override func setupLayout() {
        workspaceTableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(workspaceAddButton.snp.top)
        }
        
        workspaceAddButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
    }
}
