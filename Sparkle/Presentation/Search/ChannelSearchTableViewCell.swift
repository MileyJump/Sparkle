//
//  SearchTableViewCell.swift
//  Sparkle
//
//  Created by 최민경 on 12/27/24.
//

import UIKit

import Then
import SnapKit
final class SearchTableViewCell: BaseTableViewCell {
    
    let hashLabel = UILabel().then {
        $0.text = "#"
        $0.textColor = .sparkleBrandBlackColor
        $0.font = UIFont.boldSystemFont(ofSize: 13)
    }
 
    let channelNameLabel = UILabel().then {
        $0.text = "일반"
        $0.textColor = .sparkleBrandBlackColor
        $0.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setupSubviews() {
        addSubview(hashLabel)
        addSubview(channelNameLabel)
    }
    
    override func setupLayout() {
        
        hashLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerY.equalToSuperview()
        }
        
        channelNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(hashLabel.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func bind(channel: String) {
        
    }
}

