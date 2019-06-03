//
//  TBTextView.swift
//  TBExtensions
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 TrusBe. All rights reserved.
//

import UIKit

extension UITextView {
    // 添加链接文本（链接为空时则表示普通文本）
    public func appendLinkString(string: String, withURLString: String?) {
        //原来的文本内容
        let attrString:NSMutableAttributedString = NSMutableAttributedString()
        attrString.append(self.attributedText)
        
        //新增的文本内容（使用默认设置的字体样式）
        let attrs = [NSAttributedString.Key.font : self.font!]
        let appendString = NSMutableAttributedString(string: string, attributes:attrs)
        //判断是否是链接文字
        if let str = withURLString {
            let range:NSRange = NSMakeRange(0, appendString.length)
            appendString.beginEditing()
            appendString.addAttribute(NSAttributedString.Key.link, value:str, range:range)
            appendString.endEditing()
        }
        //合并新的文本
        attrString.append(appendString)
        //设置合并后的文本
        self.attributedText = attrString
    }
}
