//
//  HomeInitialViewController.swift
//  Sparkle
//
//  Created by 최민경 on 11/11/24.
//

import UIKit

import RxSwift


final class HomeInitialViewController: BaseViewController<HomeInitialView> {
    
    var disposeBag = DisposeBag()
    
    let ChannelReactor = HomeInitialViewReactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavigationBar() {
        
    }
    
    func bind(reactor: HomeInitialViewReactor) {
        // 섹션 헤더 클릭 시 확장/축소 상태 변경
        rootView.tableView.rx.itemSelected
            .map { HomeInitialViewReactor.Action.toggleSection($0.section) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // 섹션 데이터 바인딩
        reactor.state
            .map { $0.sections }
            .bind(to: rootView.tableView.rx.items) { tableView, index, item in
                let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
                return cell
            }
            .disposed(by: disposeBag)
    }
}
