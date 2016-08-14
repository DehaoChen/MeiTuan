//
//  CDH_CategoryViewController.swift
//  MeiTuan
//
//  Created by chendehao on 16/8/14.
//  Copyright © 2016年 CDHao. All rights reserved.
//

import UIKit

class CDH_CategoryViewController: UIViewController {
    
    
    // MARK: - 懒加载控件属性
    lazy private var tableView : CDH_DoubleTableView = {
        let tableView = CDH_DoubleTableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - 懒加载数据
    lazy private var categoryData = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        // 设置在 Popover 中的尺寸, 320, 480 比较好看, 随便设置也可以
        // preferredContentSize = CGSize(width: 320, height: 480)
        
        // 添加子控件
        view.addSubview(tableView)
        
    }
}

// MARK: - 添加子控件
extension CDH_CategoryViewController {
    
    
}

// MARK: - CDH_DoubleTableViewDataSource
extension CDH_CategoryViewController : CDH_DoubleTableViewDataSource {
    
}

// MARK: - CDH_DoubleTableViewDelegate
extension CDH_CategoryViewController : CDH_DoubleTableViewDelegate {
    
}



















