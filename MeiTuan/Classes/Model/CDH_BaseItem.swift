//
//  CDH_BaseItem.swift
//  MeiTuan
//
//  Created by chendehao on 16/8/14.
//  Copyright © 2016年 CDHao. All rights reserved.
//

import UIKit

class CDH_BaseItem: NSObject {
    
    init(dict : [String : NSObject]){
        super.init()
        
        setValuesForKeys(dict)
    }
    // 重写这个方法, 避免模型中 找不到对应的属性与字典中 key 配对
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

    
}
