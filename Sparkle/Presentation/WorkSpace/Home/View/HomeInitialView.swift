//
//  HomeInitialView.swift
//  Sparkle
//
//  Created by 최민경 on 11/11/24.
//

import UIKit

import SnapKit

final class HomeInitialView: BaseView {
    
    private let channelButton = ChannelsButton(title: "채널", image: UIImage(systemName: "chevron.right"), backgroundColor: .sparkleBrandWhiteColor, tintColor: .sparkleTextPrimaryColor, font: UIFont.boldSystemFont(ofSize: 14))
    
    let channelTableView = UITableView().then {
        $0.backgroundColor = .blue
    }
    
    let directTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        
        addSubview(channelButton)
        addSubview(channelTableView)
        addSubview(directTableView)
    }
    
    override func setupLayout() {
        
        channelButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(56)
        }
        
        channelTableView.snp.makeConstraints { make in
            make.top.equalTo(channelButton.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(41)
            
        }
    }
}
