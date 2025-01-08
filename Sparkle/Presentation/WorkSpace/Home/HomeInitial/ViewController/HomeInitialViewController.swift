//
//  HomeInitialViewController.swift
//  Sparkle
//
//  Created by 최민경 on 11/11/24.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

final class HomeInitialViewController: BaseViewController<HomeInitialView> {
    
    var disposeBag = DisposeBag()
    
    let ChannelReactor = HomeInitialViewReactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setupUI() {
        rootView.channelTableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
    }
}

extension HomeInitialViewController: View {
    
    func bind(reactor: HomeInitialViewReactor) {
      
    }
}
