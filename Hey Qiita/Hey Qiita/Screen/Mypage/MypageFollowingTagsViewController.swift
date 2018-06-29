//
//  MypageFollowingTagsViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/13.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

/// マイページ　フォロー中のタグ一覧画面
final class MypageFollowingTagsViewController: UIViewController {
    private lazy var tableView = UITableView()
    private var tags: [Tag] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    private func initLayout() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.register(TagCell.self)
        tableView.snp.makeConstraintsEqualToSuperview()
    }
    
    func set(tags: [Tag]) {
        self.tags = tags
        tableView.reloadData()
    }
}

extension MypageFollowingTagsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, as: TagCell.self)
        cell.set(tag: tags[indexPath.row])
        return cell
    }
}

extension MypageFollowingTagsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
