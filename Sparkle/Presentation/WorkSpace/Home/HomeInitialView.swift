//
//  HomeInitialView.swift
//  Sparkle
//
//  Created by 최민경 on 11/11/24.
//

import UIKit

final class HomeInitialView: BaseView {
    
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .blue
    }
    
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
