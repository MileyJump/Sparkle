//
//  HomeDefaultView.swift
//  Sparkle
//
//  Created by 최민경 on 11/22/24.
//

import UIKit

import SnapKit

final class HomeDefaultView: BaseView {
    let channelButton = ChannelsButton(title: "채널", image: UIImage(systemName: "chevron.right"), backgroundColor: .sparkleBrandWhiteColor, tintColor: .sparkleTextPrimaryColor, font: UIFont.boldSystemFont(ofSize: 14))
    
    let channelTableView = UITableView()
    
    let addChannelButton = ChannelsButton(title: "채널 추가", image: UIImage(systemName: "plus"), backgroundColor: .sparkleBrandWhiteColor, tintColor: .sparkleTextPrimaryColor, font: UIFont.systemFont(ofSize: 13))
    
    let directMessageButton = ChannelsButton(title: "다이렉트 메시지", image: UIImage(systemName: "chevron.right"), backgroundColor: .sparkleBrandWhiteColor, tintColor: .sparkleTextPrimaryColor, font: UIFont.boldSystemFont(ofSize: 14))
    
    let directTableView = UITableView()
    
    let addDirectButton = ChannelsButton(title: "새 메시지 시작", image: UIImage(systemName: "plus"), backgroundColor: .sparkleBrandWhiteColor, tintColor: .sparkleTextPrimaryColor, font: UIFont.systemFont(ofSize: 13))
    
    override func setupSubviews() {
        addSubview(channelButton)
        addSubview(channelTableView)
        addSubview(addChannelButton)
        addSubview(directMessageButton)
        addSubview(directTableView)
        addSubview(addDirectButton)
    }
    
    override func setupLayout() {
        channelButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(56)
        }
        
        channelTableView.snp.makeConstraints { make in
            make.top.equalTo(channelButton.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        addChannelButton.snp.makeConstraints { make in
            make.top.equalTo(channelTableView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(41)
        }
        
        directMessageButton.snp.makeConstraints { make in
            make.top.equalTo(addChannelButton.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(41)
        }
        
        directTableView.snp.makeConstraints { make in
            make.top.equalTo(directMessageButton.snp.bottom)
        }
        
        addDirectButton.snp.makeConstraints { make in
            make.top.equalTo(directTableView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(41)
        }
        
        
    }
    
    
    
}
