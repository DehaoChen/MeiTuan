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

// MARK: - 制定数据源协议
@objc protocol CDH_DoubleTableViewDataSource : NSObjectProtocol {
    
    // MARK: - 左边 tableView 的数据源方法
    /// 必须实现, 返回值设置 leftTableView 每组多少行 cell
    func leftTableView(leftTableView: UITableView, numberOfRowsInSection section: Int) -> Int
    /// 必须实现, 返回值设置 tableView 对应索引的 cell
    func leftTableView(leftTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell

    // MARK: - 右边 rightTableView 的数据源方法
    /// 必须实现, 返回值设置 tableView 每组多少行 cell
    func rightTableView(rightTableView: UITableView, numberOfRowsInSection section: Int ,didSelectRowAtIndexPathOfLeftTableView indexPathOfLeftTableView: NSIndexPath) -> Int
    /// 必须实现, 返回值设置 tableView 对应索引的 cell
    func rightTableView(rightTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, didSelectRowAtIndexPathOfLeftTableView indexPathOfLeftTableView: NSIndexPath) -> UITableViewCell
}
// MARK: - 制定代理协议
@objc protocol CDH_DoubleTableViewDelegate : NSObjectProtocol {
    
    /// 代理方法, 点击左边cell的时候告诉代理,左边点击了第几行
    optional func leftTableView(leftTableView : UITableView , didSelectRowAtIndexPath indexPath: NSIndexPath)
    
    /// 代理方法, 点击右边cell的时候告诉代理 右边点击了第几行,左边点击了第几行
    optional func rightTableView(rightTableView : UITableView , didSelectRowAtIndexPath indexPath : NSIndexPath, didSelectRowAtIndexPathOfLeftTableView indexPathOfLeftTableView : NSIndexPath )
}

class CDH_DoubleTableView: UIView {

    // MARK: - 控件属性
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    
    // MARK: - 代理属性
    weak var delegate : CDH_DoubleTableViewDelegate?
    // MARK: - 数据源属性
    weak var dataSource : CDH_DoubleTableViewDataSource?
    
    // MARK: - 记录属性
    var indexPathOfLeftTableView : NSIndexPath?
    
//    var indexPathOfLeftTableView : NSIndexPath = {
//        let indexPathOfLeftTableView = NSIndexPath()
//        // 设置默认的索引位置为 第 0 个位置开始, 这里可以随便设置一个值即可, 
//        // 但是如果没有设置的话, 在下面有某个地方用到indexPathOfTableView 这参数时时会直接报错
//        indexPathOfLeftTableView.indexAtPosition(0)
//        return indexPathOfLeftTableView
//    }()
    
    
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
        doubleTableView.leftTableView.dataSource = doubleTableView
        doubleTableView.leftTableView.delegate = doubleTableView
        
        doubleTableView.rightTableView.delegate = doubleTableView
        doubleTableView.rightTableView.dataSource = doubleTableView
        
        return doubleTableView
    }
}

// MARK: - UITableViewDataSource
extension CDH_DoubleTableView : UITableViewDataSource {
    /// 显示每组的行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return (dataSource?.leftTableView(tableView, numberOfRowsInSection: section))!
        }else {
            
            // 判断是否已经被点击过,
            guard let indexPathOfLeftTableView = indexPathOfLeftTableView else {
                return 0
            }
            return (dataSource?.rightTableView(tableView, numberOfRowsInSection: section, didSelectRowAtIndexPathOfLeftTableView: indexPathOfLeftTableView))!
        }
    }
    /// 显示每个 cell 的内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == leftTableView {
            let cell =  dataSource?.leftTableView(tableView, cellForRowAtIndexPath: indexPath) as? CDH_LeftTableViewCell
            return cell!
        }else {
            let cell = dataSource?.rightTableView(tableView, cellForRowAtIndexPath: indexPath, didSelectRowAtIndexPathOfLeftTableView: indexPathOfLeftTableView!)
            return cell!
        }
    }
}

// MARK: - UITableViewDelegate
extension CDH_DoubleTableView : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == leftTableView {
            indexPathOfLeftTableView = indexPath
            // 刷新界面右边的界面
            rightTableView.reloadData()
            delegate?.leftTableView?(tableView, didSelectRowAtIndexPath: indexPath)
            
            
        }else{
            delegate?.rightTableView!(tableView, didSelectRowAtIndexPath: indexPath, didSelectRowAtIndexPathOfLeftTableView: indexPathOfLeftTableView!)
        }
    }
}
