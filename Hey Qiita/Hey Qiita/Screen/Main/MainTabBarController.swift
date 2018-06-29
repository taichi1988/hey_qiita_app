//
//  MainTabBarController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/01.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    private(set) weak var whatsNewViewController: WhatsNewViewController?
    private(set) weak var searchViewController: SearchViewController?
    private(set) weak var mypageViewController: MypageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        func firstViewController<T: UIViewController>(_ vc: UIViewController?) -> T? {
            return (vc as? UINavigationController)?.viewControllers.first as? T
        }
        
        let whatsNew = UINavigationController(rootViewController: WhatsNewViewController())
        let search = UINavigationController(rootViewController: SearchViewController())
        let mypage = UINavigationController(rootViewController: MypageViewController())
        
        whatsNewViewController = firstViewController(whatsNew)
        searchViewController = firstViewController(search)
        mypageViewController = firstViewController(mypage)
        
        whatsNew.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "tab_feed"), selectedImage: nil)
        search.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "tab_search"), selectedImage: nil)
        mypage.tabBarItem = UITabBarItem(title: "Mypage", image: UIImage(named: "tab_mypage"), selectedImage: nil)
        
        viewControllers = [whatsNew, search, mypage]
    }
}
