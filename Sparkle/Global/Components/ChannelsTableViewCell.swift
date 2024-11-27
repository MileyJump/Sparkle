//
//  ChannelsTableViewCell.swift
//  Sparkle
//
//  Created by 최민경 on 11/24/24.
//

import UIKit

import SnapKit
import Then

final class ChannelsTableViewCell: BaseTableViewCell {
    
    private let hashIconLabel = UILabel()
    
    private let channelNameLabel = UILabel().then {
        $0.textColor = .sparkleTextPrimaryColor
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setupSubviews() {
        
        addSubview(hashIconLabel)
        addSubview(channelNameLabel)
    }
    
    override func setupLayout() {
        
        hashIconLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(14)
            make.verticalEdges.equalToSuperview().inset(8)
//            make.size.equalTo(44)
        }
        
        channelNameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(hashIconLabel.snp.top).inset(4)
            make.leading.equalTo(hashIconLabel.snp.trailing).offset(8)
        }
    }
    
    override func setupUI() {
        hashIconLabel.text = "#"
        channelNameLabel.text = "오픈라운지"
    }
    
}
