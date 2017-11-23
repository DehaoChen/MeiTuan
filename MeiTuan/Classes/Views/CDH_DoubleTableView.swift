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
    func leftTableView(_ leftTableView: UITableView, numberOfRowsInSection section: Int) -> Int
    /// 必须实现, 返回值设置 tableView 对应索引的 cell
    func leftTableView(_ leftTableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell

    // MARK: - 右边 rightTableView 的数据源方法
    /// 必须实现, 返回值设置 tableView 每组多少行 cell
    func rightTableView(_ rightTableView: UITableView, numberOfRowsInSection section: Int ,didSelectRowAtIndexPathOfLeftTableView indexPathOfLeftTableView: IndexPath) -> Int
    /// 必须实现, 返回值设置 tableView 对应索引的 cell
    func rightTableView(_ rightTableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath, didSelectRowAtIndexPathOfLeftTableView indexPathOfLeftTableView: IndexPath) -> UITableViewCell
}
// MARK: - 制定代理协议
@objc protocol CDH_DoubleTableViewDelegate : NSObjectProtocol {
    
    /// 代理方法, 点击左边cell的时候告诉代理,左边点击了第几行
    @objc optional func leftTableView(_ leftTableView : UITableView , didSelectRowAtIndexPath indexPath: IndexPath)
    
    /// 代理方法, 点击右边cell的时候告诉代理 右边点击了第几行,左边点击了第几行
    @objc optional func rightTableView(_ rightTableView : UITableView , didSelectRowAtIndexPath indexPath : IndexPath, didSelectRowAtIndexPathOfLeftTableView indexPathOfLeftTableView : IndexPath )
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
    var indexPathOfLeftTableView : IndexPath?
    
    // 加载xib 的时候会调动这个方法
    override func awakeFromNib() {
        // 必须先调用父类的方法
        super.awakeFromNib()
    }
}
// MARK: - 提供外部快速方法
extension CDH_DoubleTableView {
    class func doubleTableView() -> CDH_DoubleTableView{
        let doubleTableView = Bundle.main.loadNibNamed("CDH_DoubleTableView", owner: nil, options: nil)?.first as! CDH_DoubleTableView
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            indexPathOfLeftTableView = indexPath
            // 刷新界面右边的界面
            rightTableView.reloadData()
            delegate?.leftTableView?(tableView, didSelectRowAtIndexPath: indexPath)
            
        }else{
            delegate?.rightTableView?(tableView, didSelectRowAtIndexPath: indexPath, didSelectRowAtIndexPathOfLeftTableView: indexPathOfLeftTableView!)
        }
    }
}
