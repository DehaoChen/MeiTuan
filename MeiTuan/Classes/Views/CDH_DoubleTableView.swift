//
//  CDH_DoubleTableView.swift
//  MeiTuan
//
//  Created by chendehao on 16/8/14.
//  Copyright © 2016年 CDHao. All rights reserved.
//

/**
 模仿 tableView,给 doubuleView设置数据源和代理
 */


import UIKit


protocol CDH_DoubleTableViewDataSource : NSObjectProtocol {
    
}
@objc protocol CDH_DoubleTableViewDelegate : NSObjectProtocol {
    
    /// 点击左边cell的时候告诉代理,左边点击了第几行
    optional func doubleTableView(doubleTable : CDH_DoubleTableView , selectedLeftTableView letfRow : Int)
    
    /// 点击右边cell的时候告诉代理,右边点击了第几行,再告诉代理左边点击了第几行
    optional func doubleTableView(doubleTable : CDH_DoubleTableView , selectedLeftTableView letfRow : Int , selectedRightTableView rightRow : Int)
}

class CDH_DoubleTableView: UIView {

    // MARK: - 控件属性
    @IBOutlet weak var letfTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    
    // MARK: - 代理属性
    var delegate : CDH_DoubleTableViewDelegate?
    
    // MARK: - 数据源属性
    var dataSource : CDH_DoubleTableViewDataSource?
    
    
}
