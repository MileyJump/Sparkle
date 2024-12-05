//
//  ChannelChattingViewController.swift
//  Sparkle
//
//  Created by 최민경 on 12/5/24.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

// MARK: - ViewController
class ChannelChattingViewController: BaseViewController<ChannelChattingView> {

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }

    // MARK: - Binding
    func bind(reactor: ChatReactor) {
        
        reactor.state
            .map { $0.messages }
            .bind(to: rootView.channelTableView.rx.items(cellIdentifier: ChannelChattingCell.identifier, cellType: ChannelChattingCell.self)) { (row, message, cell) in
                print("channel TableView , Row\(row), Message\(message), cell\(cell) 성공!!")
//                cell.configure(with: message)
            }
            .disposed(by: disposeBag)

        rootView.sendButton.rx.tap
            .withLatestFrom(rootView.messageTextView.rx.text.orEmpty)
            .map { ChatReactor.Action.sendMessage($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.clearInput }
            .distinctUntilChanged()
            .filter { $0 }
            .bind(with: self, onNext: { owner, _ in
                owner.rootView.messageTextView.text = ""
            })
            .disposed(by: disposeBag)
    }
}
