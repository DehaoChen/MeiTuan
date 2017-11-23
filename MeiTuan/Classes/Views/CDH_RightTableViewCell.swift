//
//  CDH_RightTableViewCell.swift
//  MeiTuan
//
//  Created by chendehao on 16/8/14.
//  Copyright © 2016年 CDHao. All rights reserved.
//

import UIKit

class CDH_RightTableViewCell: UITableViewCell {

    // MARK: - 快速创建 rightTableViewCell 的方法
    class func rightTableViewCell(_ tableView : UITableView) -> CDH_RightTableViewCell{
        let rightTableViewCellID = "rightTableViewCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: rightTableViewCellID) as? CDH_RightTableViewCell
        if cell == nil {
            cell = CDH_RightTableViewCell(style: .default, reuseIdentifier: rightTableViewCellID)
            
        }
        return cell!
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 设置背景图片
        self.backgroundView = UIImageView(image: UIImage(named: "bg_dropdown_rightpart"))
        self.selectedBackgroundView = UIImageView(image: UIImage(named: "bg_dropdown_right_selected"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
