//
//  CDH_NavigationController.swift
//  MeiTuan
//
//  Created by chendehao on 16/8/13.
//  Copyright © 2016年 CDHao. All rights reserved.
//

import UIKit

class CDH_NavigationController: UINavigationController {
    
    // load() 这个方法只有在 oc 中才有, swift 中没有
    // initialize 是在类第一次被使用的时候调用该方法
    override class func initialize() {
        
        // 取出导航条
        let navigationbar = UINavigationBar.appearanceWhenContainedInInstancesOfClasses([self])
        
        // 设置导航条的背景图片
        navigationbar.setBackgroundImage(UIImage(named: "bg_navigationBar_normal"), forBarMetrics: .Default)
    }

}
