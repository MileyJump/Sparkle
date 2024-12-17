//
//  ChannelSettingView.swift
//  Sparkle
//
//  Created by 최민경 on 12/17/24.
//

import UIKit
import SnapKit
import Then

class ChannelSettingView: BaseView {
    // MARK: - UI Components
    
    private let channelNameLabel = UILabel().then {
        $0.text = "채널 설정"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .sparkleBrandBlackColor
    }
    
    private let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .darkGray
    }
    
    private let memberCountView = UIView()
    
    private let memberCountLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .sparkleBrandBlackColor
    }
    
    let memberCountCheckButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .sparkleBrandBlackColor
    }
    
    let memberCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical  // 가로 스크롤 설정
        
        let numberOfItemsPerRow: CGFloat = 5  // 가로에 셀 5개
        let spacing: CGFloat = 1             // 셀 간격
        let itemWidth = (UIScreen.main.bounds.width - (spacing * (numberOfItemsPerRow + 1))) / numberOfItemsPerRow
        let itemHeight: CGFloat = 100         // 셀 높이
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ChannelSettingCollectionViewCell.self, forCellWithReuseIdentifier: ChannelSettingCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    let editButton = CommonButton(title: "채널 편집", backgroundColor: .sparkleBrandWhiteColor, tintColor: .sparkleBrandBlackColor, font: UIFont.boldSystemFont(ofSize: 14), borderColor: UIColor.sparkleBrandBlackColor.cgColor)
    
    let leaveButton = CommonButton(title: "채널에서 나가기", backgroundColor: .sparkleBrandWhiteColor, tintColor: .sparkleBrandBlackColor, font: UIFont.boldSystemFont(ofSize: 14), borderColor: UIColor.sparkleBrandBlackColor.cgColor)
    
    let changeAdminButton = CommonButton(title: "채널 관리자 변경", backgroundColor: .sparkleBrandWhiteColor, tintColor: .sparkleBrandBlackColor, font: UIFont.boldSystemFont(ofSize: 14), borderColor: UIColor.sparkleBrandBlackColor.cgColor)
    
    let deleteButton = CommonButton(title: "채널 삭제", backgroundColor: .sparkleBrandWhiteColor, tintColor: .red, font: UIFont.boldSystemFont(ofSize: 14), borderColor: UIColor.red.cgColor)
    
    private var memberCollectionViewTopConstraint: Constraint?
    private var buttonStackViewTopConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup Layout
    
    override func setupLayout() {
        addSubview(channelNameLabel)
        addSubview(descriptionLabel)
        addSubview(memberCountView)
        addSubview(memberCountLabel)
        addSubview(memberCountCheckButton)
        addSubview(memberCollectionView)
        addSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(editButton)
        buttonStackView.addArrangedSubview(leaveButton)
        buttonStackView.addArrangedSubview(changeAdminButton)
        buttonStackView.addArrangedSubview(deleteButton)
        
        channelNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(channelNameLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        
        memberCountView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(56)
        }
        
        memberCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(memberCountView)
            make.leading.equalTo(memberCountView.snp.leading).offset(13)
        }
        
        memberCountCheckButton.snp.makeConstraints { make in
            make.centerY.equalTo(memberCountView)
            make.trailing.equalTo(memberCountView.snp.trailing).offset(-16)
            make.width.equalTo(27)
            make.height.equalTo(24)
        }
        
        
        memberCollectionView.snp.makeConstraints { make in
            make.top.equalTo(memberCountView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(341) // 4줄 높이 (80 * 4 + 여백)
            self.memberCollectionViewTopConstraint = make.top.equalTo(memberCountView.snp.bottom).constraint
        }
        
        // 버튼 스택 뷰의 상단 제약 조건을 저장
        buttonStackView.snp.makeConstraints { make in
            self.buttonStackViewTopConstraint = make.top.equalTo(memberCollectionView.snp.bottom).offset(8).constraint
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        
        editButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        leaveButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        changeAdminButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
    
    func bind(_ channel: SpecificChannelCheckResponse) {
        channelNameLabel.text = "#\(channel.name)"
        descriptionLabel.text = channel.description
        memberCountLabel.text = "멤버 (\(channel.channelMembers.count))"
    }
    
    func updateButtonStackViewPosition(isCollectionHidden: Bool) {
        if isCollectionHidden {
            self.buttonStackViewTopConstraint?.update(offset: 8)
        } else {
            self.buttonStackViewTopConstraint?.update(offset: 8 + 341) // 컬렉션 뷰의 높이를 추가
        }

        // 레이아웃을 강제로 갱신
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}
