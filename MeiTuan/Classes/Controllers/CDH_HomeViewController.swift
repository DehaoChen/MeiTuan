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
        
        
        let categoryItem = UIBarButtonItem(customView: <#T##UIView#>)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBarButtonItems()
        
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
        navigationItem.leftBarButtonItems = [logoItem]
    }
}
