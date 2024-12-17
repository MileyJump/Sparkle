//
//  ChannelSettingViewController.swift
//  Sparkle
//
//  Created by 최민경 on 12/17/24.
//

import UIKit

import ReactorKit

final class ChannelSettingViewController: BaseViewController<ChannelSettingView> {
    
    var disposeBag = DisposeBag()
    
    private var workspaceId: String?
    private var channelId: String?
    
    init(channelId: String, workspaceId: String?) {
        self.channelId = channelId
        self.workspaceId = workspaceId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = ChannelSettingViewReactor()
    }
    
    override func setupNavigationBar() {
        navigationItem.title = "채널 설정"
    }
    
}


extension ChannelSettingViewController: View {
    
    func bind(reactor: ChannelSettingViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: ChannelSettingViewReactor) {
        
        if let channelId, let workspaceId {
                reactor.action.onNext(.fetchInitialChannelInform(id: ChannelParameter(channelID: channelId, workspaceID: workspaceId)))
        }
        
        rootView.memberCountCheckButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.reactor?.action.onNext(.toggleMemberCollection)
                owner.toggleMemberCollectionView()
            }
            .disposed(by: disposeBag)
    }
    
    private func toggleMemberCollectionView() {
           // `memberCollectionView`의 visibility를 토글
//           rootView.memberCollectionView.isHidden.toggle()
           
           // `buttonStackView`의 위치를 업데이트
           rootView.updateButtonStackViewPosition(isCollectionHidden: rootView.memberCollectionView.isHidden)
       }
    
    private func bindState(_ reactor: ChannelSettingViewReactor) {
      
        
        reactor.state
            .map { $0.memberList }
            .asObservable()
            .bind(to: rootView.memberCollectionView.rx.items(cellIdentifier: ChannelSettingCollectionViewCell.identifier, cellType: ChannelSettingCollectionViewCell.self)) { (row, member, cell) in
                cell.bind(member)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.channelInform }
            .asObservable()
            .bind(with: self) { owner, channelInform in
                owner.rootView.bind(channelInform)
            }
            .disposed(by: disposeBag)
            
        reactor.state
            .map { $0.isMemberCollectionVisible }
            .distinctUntilChanged()
            .bind(with: self) { owner, isVisible in
                owner.rootView.memberCollectionView.isHidden = isVisible
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isChevronDown }
            .distinctUntilChanged()
            .bind(with: self) { owner, isChevronDown in
                let imageName = isChevronDown ? "chevron.up" : "chevron.down"
                owner.rootView.memberCountCheckButton.setImage(UIImage(systemName: imageName), for: .normal)
            }
            .disposed(by: disposeBag)
    }
    
    
}
