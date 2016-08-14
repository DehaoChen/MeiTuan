//
//  CDH_HomeViewController.swift
//  MeiTuan
//
//  Created by chendehao on 16/8/13.
//  Copyright © 2016年 CDHao. All rights reserved.
//

import UIKit

class CDH_HomeViewController: UIViewController {
    
    
    // MARK: - 懒加载控制器
    lazy var categoryVC : CDH_CategoryViewController = {
        // 创建内容控制器
        let categoryVC = CDH_CategoryViewController()
        
        // 设置弹出样式为 popover
        categoryVC.modalPresentationStyle = .Popover
        
        // 回调设置数据
        categoryVC.categoryItemColsure = { [weak self](item ,subTitle) -> () in
            
            // 数据刷新之后隐藏控制器  
            // 这里用动画延时所以可以现在设置数据之前, 如果当如果设置数据是耗时操作, 则是最好不要这样写
            categoryVC.dismissViewControllerAnimated(true, completion: {
                // 并且开启按钮点击功能
                self!.barButtonItemsEnable()
            })
            
            guard subTitle != nil else{
                // 设置数据
                let categoryView = self!.categoryItem.customView as! CDH_BarButtonItemView
                categoryView.iconButton.setImage(UIImage(named: "icon_category_-1") , forState: .Normal)
                categoryView.iconButton.setImage(UIImage(named: "icon_category_highlighted_-1"), forState: .Highlighted)
                categoryView.titleLabel.text = "美团"
                categoryView.subTitleLabel.text = "全部分类"
                
                return
            }
            // 设置数据
            let categoryView = self!.categoryItem.customView as! CDH_BarButtonItemView
            categoryView.iconButton.setImage(UIImage(named: item.icon) , forState: .Normal)
            categoryView.iconButton.setImage(UIImage(named: item.highlighted_icon), forState: .Highlighted)
            categoryView.titleLabel.text = item.name
            categoryView.subTitleLabel.text = subTitle
        }
        
        return categoryVC
    }()
    lazy var regionVC : CDH_RegionViewController = {
        // 创建内容控制器
        let regionVC = CDH_RegionViewController()
        
        // 设置弹出样式为 popover
        regionVC.modalPresentationStyle = .Popover
        
        // 回调设置数据
        regionVC.regionItemColsure = {[weak self] (item , subTitle ) in
            
            // 数据刷新之后隐藏控制器
            // 这里用动画延时所以可以现在设置数据之前, 如果当如果设置数据是耗时操作, 则是最好不要这样写
            regionVC.dismissViewControllerAnimated(true, completion: {
                // 并且开启按钮点击功能
                self!.barButtonItemsEnable()
            })
            
            guard subTitle != nil else{
                // 设置数据
                let regionView = self!.regionItem.customView as! CDH_BarButtonItemView
                regionView.titleLabel.text = "广州"
                regionView.subTitleLabel.text = "全部区域"
                return
            }
            // 设置数据
            let regionView = self!.regionItem.customView as! CDH_BarButtonItemView

            regionView.titleLabel.text = item.name
            regionView.subTitleLabel.text = subTitle
        }
        return regionVC
    }()
    lazy var sortVC : CDH_SortViewController = {
        // 创建内容控制器
        let sortVC = CDH_SortViewController()
        
        // 设置弹出样式为 popover
        sortVC.modalPresentationStyle = .Popover
        
        return sortVC
    }()
    
    // MARK: - 懒加载自定义的items控件
    lazy var categoryItem : UIBarButtonItem = {
        // 初始化分类 Item
        let categoryView = CDH_BarButtonItemView.barButtonItemView(UIImage(named: "icon_category_-1")!, highlightedImage: UIImage(named: "icon_category_highlighted_-1")!, title: "美团", subTitle: "全部分类")
        let categoryItem = UIBarButtonItem(customView: categoryView)
        
        // 监听点击事件
        categoryView.iconButton.addTarget(self, action: #selector(categoryClick), forControlEvents: .TouchUpInside)
        return categoryItem
    }()
    lazy var regionItem : UIBarButtonItem = {
        // 初始化分类 Item
        let regionView = CDH_BarButtonItemView.barButtonItemView(UIImage(named: "icon_district" )!, highlightedImage: UIImage(named: "icon_district_highlighted")!, title: "广州", subTitle: "全部区域")
        
        let regionItem = UIBarButtonItem(customView: regionView)
        
        // 监听点击事件
        regionView.iconButton.addTarget(self, action: #selector(regionClick), forControlEvents: .TouchUpInside)
        
        
        return regionItem
    }()
    lazy var sortItem : UIBarButtonItem = {
        // 初始化分类 Item
        let sortView = CDH_BarButtonItemView.barButtonItemView(UIImage(named: "icon_sort")!, highlightedImage : UIImage(named: "icon_sort_highlighted" )!, title : "排序", subTitle: "默认顺序")
        
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
        presentVC(categoryVC, barButtonItem: categoryItem)
    }
    @objc private func regionClick(){
        presentVC(regionVC, barButtonItem: regionItem)
    }
    @objc private func sortClick(){
        presentVC(sortVC, barButtonItem: sortItem)
    }
    private func presentVC(viewController : UIViewController, barButtonItem : UIBarButtonItem){
        // 0.设置代理, 通过代理取消当点击了其他按钮的时候 dismiss 当天下拉菜单
        viewController.popoverPresentationController?.delegate = self
        // 1.设置内容控制器的弹出位置
        viewController.popoverPresentationController?.barButtonItem = barButtonItem
        // 2.弹出内容控制器
        presentViewController(viewController, animated: true, completion: nil)
        
        // 3.将所有的按钮设置为不能点击
        barButtonItemsDisable()
    }
    
    // MARK: - 是否交互的方法
    /// 可以交互
    func barButtonItemsEnable() -> Void {
        categoryItem.enabled = true
        regionItem.enabled = true
        sortItem.enabled = true
    }
    /// 不可以交互
    func barButtonItemsDisable() -> Void {
        categoryItem.enabled = false
        regionItem.enabled = false
        sortItem.enabled = false
    }
}
// MARK: - UIPopoverPresentationControllerDelegate
extension CDH_HomeViewController : UIPopoverPresentationControllerDelegate {
    // 当通过 popover 出来的 Controller 被 dismiss 时, 开启所有的 barButtonItems 交互使能
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        barButtonItemsEnable()
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
        navigationItem.leftBarButtonItems = [logoItem, categoryItem, regionItem, sortItem]
    }
}
