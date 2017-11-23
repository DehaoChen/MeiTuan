//
//  CDH_RegionViewController.swift
//  MeiTuan
//
//  Created by chendehao on 16/8/14.
//  Copyright © 2016年 CDHao. All rights reserved.
//

/**
 CDH_CategoryViewController.swift : 使用的是系统的方法字典转模型
 CDH_RegionViewController.swift : 使用的是 MJExtension 字典转模型
 CDH_SortViewController.swift : 使用的是 MJExtension 字典转模型
 */

import UIKit

/// 自定义定义闭包,并且给闭包区别名 : 分类闭包
typealias RegionClosure = ((_ regionItem : CDH_RegionItem ,  _ subregionTitle : String?)->())

class CDH_RegionViewController: UIViewController {

     // 定义一个闭包的属性
    var regionItemColsure : RegionClosure?
    
    // MARK: - 懒加载控件属性
    lazy fileprivate var doubleTableView : CDH_DoubleTableView = {
        let doubleTableView = CDH_DoubleTableView.doubleTableView()
        // 设置 frame
        doubleTableView.frame = self.view.bounds
        
        // 设置数据源和代理
        doubleTableView.delegate = self
        doubleTableView.dataSource = self
        return doubleTableView
    }()
    
    // MARK: - 懒加载数据
    lazy fileprivate var regionDatas : [CDH_RegionItem] = {
        var tempDatas = [CDH_RegionItem]()
        
        // 1.获取到plist 文件的路径
        let regionPath = Bundle.main.path(forResource: "gz", ofType: "plist")
        
        // 2.读取 plist 文件
        guard let regionArray = NSArray(contentsOfFile: regionPath!) as? [[String : NSObject]] else {
            return tempDatas
        }
        
        // 3.将字典转模型对象
        for dict in regionArray {
            tempDatas.append(CDH_RegionItem(dict :  dict))
        }
        return tempDatas
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // 设置在 Popover 中的尺寸, 320, 480 比较好看, 随便设置也可以
        preferredContentSize = CGSize(width: 320, height: 480)
        
        // 添加子控件
        view.addSubview(doubleTableView)
    }
}

// MARK: - 添加子控件
extension CDH_RegionViewController {
}

// MARK: - CDH_DoubleTableViewDataSource
extension CDH_RegionViewController : CDH_DoubleTableViewDataSource {
    
    // MARK: - leftTableViewDataSourceDataSource
    func leftTableView(_ leftTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionDatas.count
    }
    func leftTableView(_ leftTableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        // 创建 leftTableViewCell
        let cell = CDH_LeftTableViewCell.leftTableViewCell(leftTableView)
        // 设置数据
        let regionItem : CDH_RegionItem = regionDatas[indexPath.row]
        cell.textLabel?.text = regionItem.name
        
        return cell
    }
    
    
    // MARK: - rightTableViewDataSource
    func rightTableView(_ rightTableView: UITableView, numberOfRowsInSection section: Int, didSelectRowAtIndexPathOfLeftTableView indexPathOfLeftTableView: IndexPath) -> Int {
        
        let regionItem : CDH_RegionItem = regionDatas[indexPathOfLeftTableView.row]
        // 如果没有子分类数据则返回 0
        return regionItem.subregions?.count ?? 0
    }
    func rightTableView(_ rightTableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath, didSelectRowAtIndexPathOfLeftTableView indexPathOfLeftTableView: IndexPath) -> UITableViewCell {
        
        // 创建 rightTableViewCell
        let cell = CDH_RightTableViewCell.rightTableViewCell(rightTableView)
        // 设置数据
        let regionItem : CDH_RegionItem = regionDatas[indexPathOfLeftTableView.row]
        cell.textLabel?.text = regionItem.subregions![indexPath.row]
        
        return cell
    }
}

// MARK: - CDH_DoubleTableViewDelegate
extension CDH_RegionViewController : CDH_DoubleTableViewDelegate {
    /// 代理方法, 点击左边cell的时候告诉代理,左边点击了第几行
    func leftTableView(_ leftTableView : UITableView , didSelectRowAtIndexPath indexPath: IndexPath){
        // 1.取出数据
        let regionItem = regionDatas[indexPath.row]
        guard regionItem.subregions != nil else {
            // 没有子分类则直接通过 闭包 回调设置分类按钮的数据显示
            regionItemColsure?(regionItem, nil)
            
            return
        }
        // 有分类则不通过 闭包 回调设置按钮数据的显示
        // 但是此时, 要将子分类默认选中为右边的第 0 个(全部)的选项
    }
    
    /// 代理方法, 点击右边cell的时候告诉代理 右边点击了第几行,左边点击了第几行
    func rightTableView(_ rightTableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath, didSelectRowAtIndexPathOfLeftTableView indexPathOfLeftTableView: IndexPath) {
        
        // 1.取出数据
        let regionItem = regionDatas[indexPathOfLeftTableView.row]
        let subTitle = regionItem.subregions![indexPath.row]
        
        // 2.取出右边点击子分类的数据
        regionItemColsure?(regionItem, subTitle)
    }
}

