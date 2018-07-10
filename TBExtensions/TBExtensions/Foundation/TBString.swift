//
//  TBString.swift
//  TBExtensions
//
//  Created by xuntong on 2018/7/10.
//  Copyright © 2018年 TrusBe. All rights reserved.
//

import Foundation

extension String {
    /// 16进制转10进制
    var hexToDecimal: Int {
        return Int(strtoul(self, nil, 16))
    }
    /// 16进制转2进制
    var hexToBinary: String {
        return hexToDecimal.toBinary
    }
    /// 2进制转10进制
    var binaryToDecimal: Int {
        return Int(strtoul(self, nil, 2))
    }
    /// 2进制转16进制
    var binaryToHex: String {
        return binaryToDecimal.toHex
    }

    /// 字符串转数据, 非有损转换
    func toData(_ aString: String, encoding: String.Encoding) -> Data? {
        return aString.data(using: encoding, allowLossyConversion: false)
    }
    
    /// 字符串转 UTF8 数据, 非有损转换
    internal var utf8Data: Data? {
        return toData(self, encoding: .utf8)
    }
    
    /// 字节字符串转字节数组
    internal var bytes: [UInt8] {
        var bytes = [UInt8]()

        let length = self.count
        if length & 1 != 0 {
            return bytes
        }
        
        bytes.reserveCapacity(length/2)
        var index = self.startIndex
        for _ in 0..<length/2 {
            let nextIndex = self.index(index, offsetBy: 2)
            if let b = UInt8(self[index..<nextIndex], radix: 16) {
                bytes.append(b)
            } else {
                return bytes
            }
            index = nextIndex
        }
        return bytes
    }
}
