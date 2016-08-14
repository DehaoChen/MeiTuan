//
//  CDH_SortViewController.swift
//  MeiTuan
//
//  Created by chendehao on 16/8/14.
//  Copyright © 2016年 CDHao. All rights reserved.
//

/**
 CDH_CategoryViewController.swift : 使用的是系统的方法字典转模型
 CDH_Regi.onViewController.swift : 使用的是 MJExtension 字典转模型
 CDH_SortViewController.swift : 使用的是 MJExtension 字典转模型
 */

import UIKit

/// 自定义定义闭包,并且给闭包区别名 : 分类闭包
typealias SortClosure = ((SortItem : CDH_SortItem ,  subSortTitle : String?)->())

class CDH_SortViewController: UIViewController {
    
    // 定义一个闭包的属性
    var SortItemColsure = SortClosure?()
    
    // MARK: - 懒加载数据
    lazy private var SortDatas : [CDH_SortItem] = {
        var tempDatas = [CDH_SortItem]()
        
        // 1.获取到plist 文件的路径
        let SortPath = NSBundle.mainBundle().pathForResource("sorts", ofType: "plist")
        
        // 2.读取 plist 文件
        guard let SortArray = NSArray(contentsOfFile: SortPath!) as? [[String : NSObject]] else {
            return tempDatas
        }
        
        // 3.将字典转模型对象
        for dict in SortArray {
            tempDatas.append(CDH_SortItem(dict :  dict))
        }
        return tempDatas
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        // 设置在 Popover 中的尺寸, 320, 480 比较好看, 随便设置也可以
        preferredContentSize = CGSize(width: 320, height: 480)
        
        // 添加子控件
//        view.addSubview(doubleTableView)
    }
}

// MARK: - 添加子控件
extension CDH_SortViewController {
}

