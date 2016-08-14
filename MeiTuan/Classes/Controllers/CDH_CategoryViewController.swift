//
//  CDH_CategoryViewController.swift
//  MeiTuan
//
//  Created by chendehao on 16/8/14.
//  Copyright © 2016年 CDHao. All rights reserved.
//

/**
 CDH_CategoryViewController.swift : 使用的是系统的方法字典转模型
 CDH_DistrictViewController.swift : 使用的是 MJExtension 字典转模型
 CDH_SortViewController.swift : 使用的是 MJExtension 字典转模型
 */

import UIKit

class CDH_CategoryViewController: UIViewController {
    
    
    // MARK: - 懒加载控件属性
    lazy private var doubleTableView : CDH_DoubleTableView = {
        let doubleTableView = CDH_DoubleTableView.doubleTableView()
        // 设置 frame
        doubleTableView.frame = self.view.bounds
        
        // 设置数据源和代理
        doubleTableView.delegate = self
        doubleTableView.dataSource = self
        return doubleTableView
    }()
    
    // MARK: - 懒加载数据
    lazy private var categoryDatas : [CDH_CategoryItem] = {
        var tempDatas = [CDH_CategoryItem]()
        
        // 1.获取到plist 文件的路径
        let categoryPath = NSBundle.mainBundle().pathForResource("categories", ofType: "plist")
        
        // 2.读取 plist 文件
        guard let categoryArray = NSArray(contentsOfFile: categoryPath!) as? [[String : NSObject]] else {
            return tempDatas
        }
        
        // 3.将字典转模型对象
        for dict in categoryArray {
            tempDatas.append(CDH_CategoryItem(dict :  dict))
        }

        return tempDatas
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        // 设置在 Popover 中的尺寸, 320, 480 比较好看, 随便设置也可以
        preferredContentSize = CGSize(width: 320, height: 480)
        
        // 添加子控件
        view.addSubview(doubleTableView)
        
    }
}

// MARK: - 添加子控件
extension CDH_CategoryViewController {
    
    
}

// MARK: - CDH_DoubleTableViewDataSource
extension CDH_CategoryViewController : CDH_DoubleTableViewDataSource {
    
    // MARK: - leftTableViewDataSourceDataSource
    func leftTableView(leftTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func leftTableView(leftTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let letfTableViewCellID = "letfTableViewCellID"
        var cell = leftTableView.dequeueReusableCellWithIdentifier(letfTableViewCellID)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: letfTableViewCellID)
            cell?.backgroundColor = UIColor.greenColor()
        }
        cell?.textLabel?.text = "letfCell--123"
        return cell!
    }
    
    // MARK: - rightTableViewDataSource
    func rightTableView(rightTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let categoryItem : CDH_CategoryItem = categoryDatas[section]
        // 如果没有子分类数据则返回 0
        return categoryItem.subcategories?.count ?? 0
    }
    func rightTableView(rightTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let rightTableViewCellID = "letfTableViewCellID"
        var cell = rightTableView.dequeueReusableCellWithIdentifier(rightTableViewCellID)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: rightTableViewCellID)
            cell?.backgroundColor = UIColor.greenColor()
        }
        cell?.textLabel?.text = "rightCell--123"
        return cell!
    }
    
}

// MARK: - CDH_DoubleTableViewDelegate
extension CDH_CategoryViewController : CDH_DoubleTableViewDelegate {
    
}



















