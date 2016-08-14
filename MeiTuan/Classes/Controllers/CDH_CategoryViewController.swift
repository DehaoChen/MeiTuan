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

/// 自定义定义闭包,并且给闭包区别名 : 分类闭包
typealias CategoryClosure = (( categoryItem : CDH_CategoryItem ,  subcategoryTitle : String?)->())

class CDH_CategoryViewController: UIViewController {
    
    // 定义一个闭包的属性
    var categoryItemColsure = CategoryClosure?()
    
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
        return categoryDatas.count
    }
    func leftTableView(leftTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 创建 leftTableViewCell
        let cell = CDH_LeftTableViewCell.leftTableViewCell(leftTableView)
        // 设置数据
        let categoryItem : CDH_CategoryItem = categoryDatas[indexPath.row]
        cell.imageView?.image = UIImage(named: categoryItem.small_icon)
        cell.textLabel?.text = categoryItem.name
        
        return cell
    }
    
    
    // MARK: - rightTableViewDataSource
    func rightTableView(rightTableView: UITableView, numberOfRowsInSection section: Int, didSelectRowAtIndexPathOfLeftTableView indexPathOfLeftTableView: NSIndexPath) -> Int {
        
        let categoryItem : CDH_CategoryItem = categoryDatas[indexPathOfLeftTableView.row]
        // 如果没有子分类数据则返回 0
        return categoryItem.subcategories?.count ?? 0
    }
    func rightTableView(rightTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, didSelectRowAtIndexPathOfLeftTableView indexPathOfLeftTableView: NSIndexPath) -> UITableViewCell {
 
        // 创建 rightTableViewCell
        let cell = CDH_RightTableViewCell.rightTableViewCell(rightTableView)
        // 设置数据
        let categoryItem : CDH_CategoryItem = categoryDatas[indexPathOfLeftTableView.row]
        cell.textLabel?.text = categoryItem.subcategories![indexPath.row]
        
        return cell
    }
}

// MARK: - CDH_DoubleTableViewDelegate
extension CDH_CategoryViewController : CDH_DoubleTableViewDelegate {
    /// 代理方法, 点击左边cell的时候告诉代理,左边点击了第几行
    func leftTableView(leftTableView : UITableView , didSelectRowAtIndexPath indexPath: NSIndexPath){
        // 1.取出数据
        let categoryItem = categoryDatas[indexPath.row]
        guard categoryItem.subcategories != nil else {
            // 没有子分类则直接通过 闭包 回调设置分类按钮的数据显示
            categoryItemColsure!(categoryItem : categoryItem, subcategoryTitle: nil)
    
            return
        }
        // 有分类则不通过 闭包 回调设置按钮数据的显示
        // 但是此时, 要将子分类默认选中为右边的第 0 个(全部)的选项
    }
    
    /// 代理方法, 点击右边cell的时候告诉代理 右边点击了第几行,左边点击了第几行
    func rightTableView(rightTableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath, didSelectRowAtIndexPathOfLeftTableView indexPathOfLeftTableView: NSIndexPath) {
        
        // 1.取出数据
        let categoryItem = categoryDatas[indexPathOfLeftTableView.row]
        let subTitle = categoryItem.subcategories![indexPath.row]
        
        // 2.取出右边点击子分类的数据
        categoryItemColsure!(categoryItem : categoryItem, subcategoryTitle : subTitle)
    }
}



















