//
//  MainTabBar.swift
//  Sparkle
//
//  Created by 최민경 on 10/30/24.

//

import UIKit

enum SparkleTabBar {
    
    case mainHome
    case direct
    case search
    case setting
    
    var viewController: UIViewController {
        switch self {
        case .mainHome:
            return HomeDefaultViewController()
        case .search:
            return ChannelSearchViewController()
        case .direct:
            return DirectViewController()
        case .setting:
            return SettingViewController()
        }
    }
    
    var title: String {
        switch self {
        case .mainHome:
            return "홈"
        case .direct:
            //            return StringLiterals.Phrase.searchTabBar
            return "DM"
        case .search:
            return "탐색"
        case .setting:
            return "설정"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .mainHome:
            return UIImage(systemName: "list.bullet")
        case .direct:
            //            return UIImage(systemName: "message")
            return UIImage(named: "디엠")
        case .search:
            return UIImage(systemName: "rectangle.and.text.magnifyingglass")
        case .setting:
//            return UIImage(systemName: "gearshape")
            return UIImage(named: "설정")
        }
    }
    
    var seletedImage: UIImage? {
        switch self {
        case .mainHome:
            return UIImage(systemName: "list.bullet")
        case .direct:
//            return UIImage(systemName: "message.fill")
            return UIImage(named: "디엠")
        case .search:
            return UIImage(systemName: "rectangle.and.text.magnifyingglass")
        case .setting:
//            return UIImage(systemName: "gearshape.fill")
            return UIImage(named: "설정")
        }
    }
}
