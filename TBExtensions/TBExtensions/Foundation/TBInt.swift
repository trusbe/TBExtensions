//
//  TBInt.swift
//  TBExtensions
//
//  Created by TrusBe on 2018/7/10.
//  Copyright © 2018年 TrusBe. All rights reserved.
//

import Foundation

extension Int {
    /// 10进制转2进制
    var tb_toBinary: String {
        return String(self, radix: 2, uppercase: true)
    }
    
    /// 10进制转16进制
    var tb_toHex: String {
        return String(self, radix: 16)
    }
}
