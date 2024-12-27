//
//  HomeView.swift
//  Sparkle
//
//  Created by 최민경 on 11/7/24.
//

import UIKit

class workspaceInitialView: BaseView {
    
    private let releaseReadyLabel = UILabel().then {
        $0.text = "출시 준비 완료!"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        $0.textAlignment = .center
    }
    
    private let workspaceReadyMessageLabel = UILabel().then {
        $0.text = "새싹님의 조직을 위해 새로운 워크스페이스를 시작할 준비가 완료되었어요!"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let workspaceImageView = UIImageView().then {
        $0.image = UIImage(named: "launching")
    }
    
    let createWorkspaceButton = CommonButton(image: nil, title: "워크스페이스 생성", backgroundColor: UIColor.sparkleBrandOrangeColor, tintColor: UIColor.white, font: UIFont.boldSystemFont(ofSize: 14))
    
    init(releaseText: String, workspaceMessage: String, workspaceImage: UIImage?) {
        super.init(frame: .zero)
        releaseReadyLabel.text = releaseText
        workspaceImageView.image = workspaceImage
        workspaceReadyMessageLabel.text = workspaceMessage
        print("HomeView init")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("HomeView super init")
    }
    
    override func setupSubviews() {
        
        addSubview(releaseReadyLabel)
        addSubview(workspaceReadyMessageLabel)
        addSubview(workspaceImageView)
        addSubview(createWorkspaceButton)
    }
    
    override func setupLayout() {
        
        releaseReadyLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(35)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        workspaceReadyMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseReadyLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(releaseReadyLabel)
        }
        
        workspaceImageView.snp.makeConstraints { make in
            make.top.equalTo(workspaceReadyMessageLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
            make.width.equalTo(workspaceImageView.snp.height)
        }
        
        createWorkspaceButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(44)
        }
    }
}
