//
//  TBTabBar.swift
//  TBExtensions
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 TrusBe. All rights reserved.
//

import UIKit

fileprivate let lxfFlag: Int = 666

extension UITabBar {
    // MARK:- 显示小红点
    public func showBadgOn(index itemIndex: Int, tabbarItemNums: CGFloat = 4.0) {
        // 移除之前的小红点
        self.removeBadgeOn(index: itemIndex)
        
        // 创建小红点
        let bageView = UIView()
        bageView.tag = itemIndex + lxfFlag
        bageView.layer.cornerRadius = 5
        bageView.backgroundColor = UIColor.red
        let tabFrame = self.frame
        
        // 确定小红点的位置
        let percentX: CGFloat = (CGFloat(itemIndex) + 0.59) / tabbarItemNums
        let x: CGFloat = CGFloat(ceilf(Float(percentX * tabFrame.size.width)))
        let y: CGFloat = CGFloat(ceilf(Float(0.115 * tabFrame.size.height)))
        bageView.frame = CGRect(x: x, y: y, width: 10, height: 10)
        self.addSubview(bageView)
    }
    
    // MARK:- 隐藏小红点
    public func hideBadg(on itemIndex: Int) {
        // 移除小红点
        self.removeBadgeOn(index: itemIndex)
    }
    
    // MARK:- 移除小红点
    fileprivate func removeBadgeOn(index itemIndex: Int) {
        // 按照tag值进行移除
        _ = subviews.map {
            if $0.tag == itemIndex + lxfFlag {
                $0.removeFromSuperview()
            }
        }
    }
}
