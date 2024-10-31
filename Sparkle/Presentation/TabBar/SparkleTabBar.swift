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
    case setting
    
    var viewController: UIViewController {
        switch self {
        case .mainHome:
            return HomeViewController()
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
        case .setting:
            return "설정"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .mainHome:
            return UIImage(systemName: "house")
        case .direct:
            return UIImage(systemName: "message")
        case .setting:
            return UIImage(systemName: "gearshape")
        }
    }
    
    var seletedImage: UIImage? {
        switch self {
        case .mainHome:
            return UIImage(systemName: "house.fill")
        case .direct:
            return UIImage(systemName: "message.fill")
        case .setting:
            return UIImage(systemName: "gearshape.fill")
        }
    }
    
}
