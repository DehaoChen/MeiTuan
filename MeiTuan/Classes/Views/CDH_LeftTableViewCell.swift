//
//  CDH_LeftTableViewCell.swift
//  MeiTuan
//
//  Created by chendehao on 16/8/14.
//  Copyright © 2016年 CDHao. All rights reserved.
//

import UIKit

class CDH_LeftTableViewCell: UITableViewCell {
    
    // MARK: - 快速创建 leftTableViewCell 的方法
    class func leftTableViewCell(tableView : UITableView) -> CDH_LeftTableViewCell{
        let letfTableViewCellID = "letfTableViewCellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(letfTableViewCellID) as? CDH_LeftTableViewCell
        if cell == nil {
            cell = CDH_LeftTableViewCell(style: .Default, reuseIdentifier: letfTableViewCellID)
            
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 设置背景图片
        self.backgroundView = UIImageView(image: UIImage(named: "bg_dropdown_leftpart"))
        self.selectedBackgroundView = UIImageView(image: UIImage(named: "bg_dropdown_left_selected"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
