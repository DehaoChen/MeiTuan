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


@objc protocol CDH_DoubleTableViewDataSource : NSObjectProtocol {
    
    // MARK: - 左边 tableView 的数据源方法
    /// 必须实现, 返回值设置 leftTableView 每组多少行 cell
    func leftTableView(leftTableView: UITableView, numberOfRowsInSection section: Int) -> Int
    /// 必须实现, 返回值设置 tableView 对应索引的 cell
    func leftTableView(leftTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell

    
    // MARK: - 右边 rightTableView 的数据源方法
    /// 必须实现, 返回值设置 tableView 每组多少行 cell
    func rightTableView(rightTableView: UITableView, numberOfRowsInSection section: Int) -> Int
    /// 必须实现, 返回值设置 tableView 对应索引的 cell
    func rightTableView(rightTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
}
@objc protocol CDH_DoubleTableViewDelegate : NSObjectProtocol {
    
    /// 点击左边cell的时候告诉代理,左边点击了第几行
    optional func doubleTableView(doubleTableView : CDH_DoubleTableView , selectedLeftTableView letfRow : Int)
    
    /// 点击右边cell的时候告诉代理,右边点击了第几行,再告诉代理左边点击了第几行
    optional func doubleTableView(doubleTableView : CDH_DoubleTableView , selectedLeftTableView letfRow : Int , selectedRightTableView rightRow : Int)
}

class CDH_DoubleTableView: UIView {

    // MARK: - 控件属性
    @IBOutlet weak var letfTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    
    // MARK: - 代理属性
    weak var delegate : CDH_DoubleTableViewDelegate?
    
    // MARK: - 数据源属性
    weak var dataSource : CDH_DoubleTableViewDataSource?
    
    // 加载xib 的时候会调动这个方法
    override func awakeFromNib() {
        // 必须先调用父类的方法
        super.awakeFromNib()
    }
}
// MARK: - 提供外部快速方法
extension CDH_DoubleTableView {
    class func doubleTableView() -> CDH_DoubleTableView{
        let doubleTableView = NSBundle.mainBundle().loadNibNamed("CDH_DoubleTableView", owner: nil, options: nil).first as! CDH_DoubleTableView
        
        // 同时给两个子控件 tablesView 设置数据源和代理
        doubleTableView.letfTableView.dataSource = doubleTableView
        doubleTableView.letfTableView.delegate = doubleTableView
        
        doubleTableView.rightTableView.delegate = doubleTableView
        doubleTableView.rightTableView.dataSource = doubleTableView
        
        return doubleTableView
    }
}

// MARK: - UITableViewDataSource
extension CDH_DoubleTableView : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let letfTableViewCellID = "letfTableViewCellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(letfTableViewCellID)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: letfTableViewCellID)
            cell?.backgroundColor = UIColor.greenColor()
        }
        cell?.textLabel?.text = "text123"
        return cell!
    }
}

// MARK: - UITableViewDelegate
extension CDH_DoubleTableView : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
