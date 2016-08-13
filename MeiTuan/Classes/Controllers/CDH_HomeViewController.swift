//
//  CDH_HomeViewController.swift
//  MeiTuan
//
//  Created by chendehao on 16/8/13.
//  Copyright © 2016年 CDHao. All rights reserved.
//

import UIKit

class CDH_HomeViewController: UIViewController {
    
    
    // MARK: - 懒加载自定义的items控件
    lazy var categoryItem : UIBarButtonItem = {
        // 初始化分类 Item
        let categoryView = CDH_BarButtonItemView.barButtonItemView(UIImage(named: "icon_category_-1")!, highlightedImage: UIImage(named: "icon_category_highlighted_-1")!, title: "美团", subTitle: "全部分类")
        let categoryItem = UIBarButtonItem(customView: categoryView)
        
        // 监听点击事件
        categoryView.iconButton.addTarget(self, action: #selector(categoryClick), forControlEvents: .TouchUpInside)
        return categoryItem
    }()
    lazy var districtItem : UIBarButtonItem = {
        // 初始化分类 Item
        let districtView = CDH_BarButtonItemView.barButtonItemView(UIImage(named: "icon_district" )!, highlightedImage: UIImage(named: "icon_district_highlighted")!, title: "广州", subTitle: "全部区域")
        
        let districtItem = UIBarButtonItem(customView: districtView)
        
        // 监听点击事件
        districtView.iconButton.addTarget(self, action: #selector(districtClick), forControlEvents: .TouchUpInside)
        
        return districtItem
    }()
    lazy var sortItem : UIBarButtonItem = {
        // 初始化分类 Item
        let sortView = CDH_BarButtonItemView.barButtonItemView(UIImage(named: "icon_sort")!, highlightedImage : UIImage(named: "icon_sort_highlighted" )!, title : "排序", subTitleLabel: "默认顺序")
        
        let sortItem = UIBarButtonItem(customView: sortView)
        
        // 监听点击事件
        sortView.iconButton.addTarget(self, action: #selector(sortClick), forControlEvents: .TouchUpInside)
        
        return sortItem
    }()
   

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBarButtonItems()
        
    }
}

// MARK: - 按钮点击事件
extension CDH_HomeViewController{
    @objc private func categoryClick(){
        print("--categoryClick--")
        
    }
    @objc private func districtClick(){
        print("--districtClick--")
    }
    @objc private func sortClick(){
        print("--sortClick--")
    }
}



// MARK: - 布局子控件
extension CDH_HomeViewController {
    // MARK: - 据导航栏
    func setUpBarButtonItems() -> Void {
        // 1.设置logo的 item // plain 平铺模式
        let  logoItem = UIBarButtonItem(image: UIImage(named: "icon_meituan_logo"), style: .Plain, target: nil, action: nil)
        // 1.1 取消点击事件的功能
        logoItem.enabled = false
        
        // 2.添加到导航栏
        navigationItem.leftBarButtonItems = [logoItem, categoryItem, districtItem, sortItem]
    }
}
