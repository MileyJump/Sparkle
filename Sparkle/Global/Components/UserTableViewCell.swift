//
//  UserTableViewCell.swift
//  Sparkle
//
//  Created by 최민경 on 11/6/24.
//

import UIKit

import SnapKit

final class UserTableViewCell: BaseTableViewCell {
    
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
     let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setupSubviews() {
        
        addSubview(profileImageView)
        addSubview(nameLabel)
    }
    
    override func setupLayout() {
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(14)
            make.verticalEdges.equalToSuperview().inset(8)
            make.size.equalTo(44)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(profileImageView.snp.top).inset(4)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
    }
}

