//
//  MypageStockListViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/09.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

/// マイページ ストック一覧画面
final class MypageStockListViewController: TimelineBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let vc = ArticleDetailViewController(article: article)
        show(vc, sender: nil)
    }
    
    func set(articles: [Article]) {
        self.articles = articles
        tableView.reloadData()
    }
}
