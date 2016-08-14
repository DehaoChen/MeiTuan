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
        
        setValuesForKeysWithDictionary(dict)
    }
    // 重写这个方法, 避免模型中 找不到与字典中对应的 key
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

    
    
}
