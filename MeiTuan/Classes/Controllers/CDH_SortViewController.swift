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
typealias SortClosure = (( _ sortItem : CDH_SortItem ,  _ subSortTitle : String?)->())

class CDH_SortViewController: UIViewController {
    
    // 定义一个闭包的属性
    var SortItemColsure : SortClosure?
    
    // 当前选中的按钮
    var selectedButton : UIButton?
    
    
    // MARK: - 懒加载数据
    lazy fileprivate var sortDatas : [CDH_SortItem] = {
        var tempDatas = [CDH_SortItem]()
        
        // 1.获取到plist 文件的路径
        let SortPath = Bundle.main.path(forResource: "sorts", ofType: "plist")
        
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
        view.backgroundColor = UIColor.white
        // 设置在 Popover 中的尺寸, 320, 480 比较好看, 随便设置也可以
        preferredContentSize = CGSize(width: 320, height: 480)
        
        // 添加子控件
        setUpSubviews()
    }
}

// MARK: - 添加子控件
extension CDH_SortViewController {
    func setUpSubviews(){
        
        let count = sortDatas.count
        
        // 定义常量
        let edgeMargin : CGFloat = 20
        let itemMargin : CGFloat = 10
        let itemW : CGFloat = 100
        let itemH : CGFloat = 35

        // 根据个数,设置在Popover中显示的尺寸
        preferredContentSize = CGSize(width: itemW + 2 * edgeMargin, height: itemMargin + (itemMargin + itemH) * CGFloat(count))
        
        // 添加按钮
        for i in 0 ..< count {
            // 1.创建 button
            let button = UIButton()
            
            // 绑定标识
            button.tag = i
            
            // 2.设置每个 button 的 frame 值
            button.frame = CGRect(x: edgeMargin, y: itemMargin + (itemMargin + itemH) * CGFloat(i), width: itemW, height: itemH)
            
            // 3.设置其他属性
            button.setTitle(sortDatas[i].label, for: UIControlState())
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            button.setTitleColor(UIColor.black, for: UIControlState())
            button.setTitleColor(UIColor.white, for: .selected)
            button.setBackgroundImage(UIImage(named: "btn_filter_normal"), for: UIControlState())
            button.setBackgroundImage(UIImage(named: "btn_filter_selected"), for: .selected)
            
            // 4.将 button 添加到控制 view 中
            view.addSubview(button)
            
            // 5.监听点击
            button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        }
    }
}

extension CDH_SortViewController {
    func buttonClick(_ sender : UIButton) -> Void {
        selectedButton?.isSelected = false
        selectedButton = sender
        selectedButton?.isSelected = true
        
        // 取出模型
        let sortItem = sortDatas[sender.tag]
        SortItemColsure?(sortItem, sortItem.label)
    }
}

