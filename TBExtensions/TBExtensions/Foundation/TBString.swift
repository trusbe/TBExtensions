//
//  TBString.swift
//  TBExtensions
//
//  Created by TrusBe on 2018/7/10.
//  Copyright © 2018年 TrusBe. All rights reserved.
//

import Foundation

extension String {
    /// 16进制转10进制
    var tb_hexToDecimal: Int {
        return Int(strtoul(self, nil, 16))
    }
    /// 16进制转2进制
    var tb_hexToBinary: String {
        return tb_hexToDecimal.tb_toBinary
    }
    /// 2进制转10进制
    var tb_binaryToDecimal: Int {
        return Int(strtoul(self, nil, 2))
    }
    /// 2进制转16进制
    var tb_binaryToHex: String {
        return tb_binaryToDecimal.tb_toHex
    }

    /// 字符串转数据, 非有损转换
    func tb_toData(_ aString: String, encoding: String.Encoding) -> Data? {
        return aString.data(using: encoding, allowLossyConversion: false)
    }
    
    /// 字符串转 UTF8 数据, 非有损转换
    internal var tb_utf8Data: Data? {
        return tb_toData(self, encoding: .utf8)
    }
    
    /// 字节字符串转字节数组
    internal var tb_bytes: [UInt8] {
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
    
    ///
    internal var tb_data: Data {
        var data = Data(capacity: self.count / 2)
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSMakeRange(0, utf16.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }
        guard data.count > 0 else { return Data() }
        return data
    }
}
















