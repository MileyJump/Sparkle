//
//  WorkspaceListTableViewCell.swift
//  Sparkle
//
//  Created by 최민경 on 12/16/24.
//

import UIKit
import Then
import SnapKit

final class WorkspaceListTableViewCell: BaseTableViewCell {
    
    private let workspaceImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .black
    }
    
    private let dateLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .gray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    override func setupSubviews() {
        contentView.addSubview(workspaceImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
    }

    override func setupLayout() {
        
        workspaceImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(workspaceImageView.snp.trailing).offset(8)
            make.top.equalTo(workspaceImageView.snp.top).offset(-4)
            make.trailing.lessThanOrEqualToSuperview().offset(-8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(workspaceImageView.snp.bottom).offset(-4)
        }
    }
    
    func bind(_ list: WorkspaceListCheckResponse) {
        
        titleLabel.text = list.name
        dateLabel.text = list.createdAt
    }
}
