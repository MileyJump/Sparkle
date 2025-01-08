//
//  WorkspaceChangeAdminView.swift
//  Sparkle
//
//  Created by 최민경 on 11/13/24.
//

import UIKit

import SnapKit

final class WorkspaceChangeAdminView: BaseView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(tableView)
    }
    
    override func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
