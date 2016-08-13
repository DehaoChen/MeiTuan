//
//  CDH_BarButtonItemView.swift
//  MeiTuan
//
//  Created by chendehao on 16/8/14.
//  Copyright © 2016年 CDHao. All rights reserved.
//

import UIKit

class CDH_BarButtonItemView: UIView {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var iconButton: UIButton!
    
    // MARK: - 提供类方法快速创建
    class func barButtonItemView( image : UIImage , highlightedImage : UIImage ,title : String , subTitle : String) -> CDH_BarButtonItemView {
        
        // 1.通过xib 加载控件
        let barButtonItemView = NSBundle.mainBundle().loadNibNamed("CDH_BarButtonItemView", owner: nil, options: nil).first as! CDH_BarButtonItemView
        
        // 2.初始化数据
        barButtonItemView.titleLabel.text = title
        barButtonItemView.subTitleLabel.text = subTitle
        barButtonItemView.iconButton.setImage(image, forState: .Normal)
        barButtonItemView.iconButton.setImage(highlightedImage, forState: .Highlighted)
        return barButtonItemView
    }
    
    override func awakeFromNib() {
        ///  不要跟随父控件拉伸, 如果不设置关闭,则会跟随父控件拉伸, 甚至有可能被拉伸小时
        autoresizingMask = UIViewAutoresizing.None
        /// 也可以通过工具栏设置, 先取消 autoresizing , 在取消掉跟随父控件的拉伸宽高拉伸, 在选择 autoresizing, 这样既可不影响对子控件布局, 不可以达到不跟随父控件
    }
}

