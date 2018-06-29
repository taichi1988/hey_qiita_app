//
//  MypageFolloweesViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/14.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

/// マイページ　フォロー中のユーザ一覧画面
final class MypageFolloweesViewController: UIViewController {
    private lazy var tableView = UITableView()
    private var followees: [User] = []
    
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
        tableView.register(UserCell.self)
        tableView.snp.makeConstraintsEqualToSuperview()
    }
    
    func set(followees: [User]) {
        self.followees = followees
        tableView.reloadData()
    }
}

extension MypageFolloweesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, as: UserCell.self)
        cell.set(user: followees[indexPath.row])
        return cell
    }
}

extension MypageFolloweesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO
    }
}
