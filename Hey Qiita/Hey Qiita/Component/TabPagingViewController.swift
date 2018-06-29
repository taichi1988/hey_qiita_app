//
//  TabPagingViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/07.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import RxSwift

struct TabPageItem {
    let title: String
    let vc: UIViewController
}

protocol TabPagingViewControllerDataSource: class {
    func tabPagingViewControllerItems(_ vc: TabPagingViewController) -> [TabPageItem]
    func tabPagingViewControllerDefaultPageIndex(_ vc: TabPagingViewController) -> Int
}

extension TabPagingViewControllerDataSource {
    func tabPagingViewControllerDefaultPageIndex(_ vc: TabPagingViewController) -> Int { return 0 }
}

// MARK: - TabPagingViewController
final class TabPagingViewController: UIViewController {
    private lazy var tabMenuView = TabMenuView()
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private let disposeBag = DisposeBag()
    private var currentPage: Int {
        let currentVC = pageViewController.viewControllers?.first ?? UIViewController()
        let vcs = dataSource.tabPagingViewControllerItems(self).map { $0.vc }
        return vcs.index(of: currentVC) ?? 0
    }
    weak var dataSource: TabPagingViewControllerDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLayout()
        initObserver()
        setup()
    }
    
    private func initLayout() {
        addChildViewController(pageViewController)
        pageViewController.didMove(toParentViewController: self)
        view.addSubviews(tabMenuView, pageViewController.view)

        tabMenuView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(tabMenuView.tabHeight).priority(.required - 1)
        }
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(tabMenuView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func initObserver() {
        // did tap event
        tabMenuView.didTapTabEvent
            .subscribe(onNext: { [weak self] in
                self?.changePage($0)
            })
            .disposed(by: disposeBag)
    }
    
    private func setup() {
        let items = dataSource.tabPagingViewControllerItems(self)
        let defaultPage = dataSource.tabPagingViewControllerDefaultPageIndex(self)
        tabMenuView.set(titles: items.map { $0.title })
        tabMenuView.currentPage = defaultPage
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.setViewControllers([items[defaultPage].vc], direction: .forward, animated: false, completion: nil)
    }
    
    private func changePage(_ page: Int) {
        let direction: UIPageViewControllerNavigationDirection = currentPage > page ? .reverse : .forward
        let vcs = dataSource.tabPagingViewControllerItems(self).map { $0.vc }
        pageViewController.setViewControllers([vcs[page]], direction: direction, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource
extension TabPagingViewController: UIPageViewControllerDataSource {
    private func nextViewController(_ viewController: UIViewController, direction: UIPageViewControllerNavigationDirection) -> UIViewController? {
        let items = dataSource.tabPagingViewControllerItems(self)
        guard var index = items.map({ $0.vc }).index(of: viewController) else { return nil }
        
        switch direction {
        case .forward: index = index + 1
        case .reverse: index = index - 1
        }
        
        return (index >= 0 && index < items.count) ? items[index].vc : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, direction: .forward)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, direction: .reverse)
    }
}

// MARK: - UIPageViewControllerDelegate
extension TabPagingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        tabMenuView.didTurnPageEvent.onNext(currentPage)
    }
}
