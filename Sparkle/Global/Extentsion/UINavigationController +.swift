//
//  UINavigationController +.swift
//  Sparkle
//
//  Created by 최민경 on 11/11/24.
//

import UIKit

extension UINavigationController {

    // RootView
    func changeRootViewController(_ rootViewController: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let window = (windowScene.delegate as? SceneDelegate)?.window else { return }
        if let _ = rootViewController as? UITabBarController {
            window.rootViewController = rootViewController
        } else {
            let navigationController = UINavigationController(rootViewController: rootViewController)
            
            window.rootViewController = navigationController
        }
        window.makeKeyAndVisible()
        
    }
    
    
    
    func changeViewController(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func changePresentViewController(_ vc: UIViewController) {
        let navi = UINavigationController(rootViewController: vc)
        self.present(navi, animated: true)
    }
    
}
