//
//  HomeDefaultView.swift
//  Sparkle
//
//  Created by 최민경 on 11/22/24.
//

import UIKit

import SnapKit
import Then

final class HomeDefaultView: BaseView {
    
    let floatingButton = FloatingButton()
    
    let channelButton = ChannelsButton(
        title: "채널",
        image: UIImage(systemName: "chevron.down"),
        backgroundColor: .sparkleBrandWhiteColor,
        tintColor: .sparkleTextPrimaryColor,
        font: UIFont.boldSystemFont(ofSize: 14)
    )
    
    let channelTableView = UITableView().then {
        $0.register(ChannelsTableViewCell.self, forCellReuseIdentifier: ChannelsTableViewCell.identifier)
    }
    
    let addChannelButton = ChannelsButton(
        title: "채널 추가",
        image: UIImage(systemName: "plus"),
        backgroundColor: .sparkleBrandWhiteColor,
        tintColor: .sparkleTextPrimaryColor,
        font: UIFont.systemFont(ofSize: 13)
    )
    
    let directMessageButton = ChannelsButton(
        title: "다이렉트 메시지",
        image: UIImage(systemName: "chevron.right"),
        backgroundColor: .sparkleBrandWhiteColor,
        tintColor: .sparkleTextPrimaryColor,
        font: UIFont.boldSystemFont(ofSize: 14)
    )
    
    let directTableView = UITableView().then {
        $0.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
    let addDirectButton = ChannelsButton(
        title: "새 메시지 시작",
        image: UIImage(systemName: "plus"),
        backgroundColor: .sparkleBrandWhiteColor,
        tintColor: .sparkleTextPrimaryColor,
        font: UIFont.systemFont(ofSize: 13)
    )
    
    private var channelTableViewHeightConstraint: Constraint?
    private var directTableViewHeightConstraint: Constraint?
    
    
    override func setupSubviews() {
        addSubview(channelButton)
        addSubview(channelTableView)
        addSubview(addChannelButton)
        addSubview(directMessageButton)
        addSubview(directTableView)
        addSubview(addDirectButton)
        addSubview(floatingButton)
    }
    
    override func setupLayout() {
        channelButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(56)
        }
        
        channelTableView.snp.makeConstraints { make in
            make.top.equalTo(channelButton.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            // 초기 높이를 0으로 설정하고 제약 조건을 저장
            self.channelTableViewHeightConstraint = make.height.equalTo(0).constraint
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
            make.height.equalTo(1)
//            self.directTableViewHeightConstraint = make.height.equalTo(0).constraint
        }
        
        addDirectButton.snp.makeConstraints { make in
            make.top.equalTo(directTableView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(41)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            make.size.equalTo(60)
        }
    }
    
    override func setupUI() {
        backgroundColor = .sparkleBackgroundSecondaryColor
    }
    
    // 테이블뷰 높이를 업데이트하는 메서드
    func updateChannelTableViewHeight() {
        print("updateChannelTableViewHeight !!!!!")
        let contentHeight = channelTableView.contentSize.height
        channelTableViewHeightConstraint?.update(offset: contentHeight)
        layoutIfNeeded()
    }
    
    func updateDirectTableViewHeight() {
        let dmContentHeight = directTableView.contentSize.height
        directTableViewHeightConstraint?.update(offset: dmContentHeight)
    }
}
