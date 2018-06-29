//
//  MainViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/01.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    private weak var mainTabBarController: MainTabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    private func initLayout() {
        view.backgroundColor = .white
        
        mainTabBarController = MainTabBarController()
        addChildViewController(mainTabBarController)
        mainTabBarController?.didMove(toParentViewController: self)
        view.addSubview(mainTabBarController.view)
        mainTabBarController.view.snp.makeConstraintsEqualToSuperview()
    }
}
