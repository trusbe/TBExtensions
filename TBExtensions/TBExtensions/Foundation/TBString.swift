//
//  TBString.swift
//  TBExtensions
//
//  Created by TrusBe on 2018/7/10.
//  Copyright © 2018年 TrusBe. All rights reserved.
//

import Foundation

public extension String {
    /// 16进制转10进制, UInt8
    internal var u8HexToDecimal: UInt8 {
        return UInt8(strtoul(self, nil, 16))
    }
    /// 16进制转2进制, UInt8
    internal var u8HexToBinary: String {
        return u8HexToDecimal.binary
    }
    /// 2进制转10进制, UInt8
    internal var u8BinaryToDecimal: UInt8 {
        return UInt8(strtoul(self, nil, 2))
    }
    /// 2进制转16进制, UInt8
    internal var u8BinaryToHex: String {
        return u8BinaryToDecimal.hex
    }
    /// 16进制转10进制, UInt16
    internal var u16HexToDecimal: UInt16 {
        return UInt16(strtoul(self, nil, 16))
    }
    /// 16进制转2进制, UInt16
    internal var u16HexToBinary: String {
        return u16HexToDecimal.binary
    }
    /// 2进制转10进制, UInt16
    internal var u16BinaryToDecimal: UInt16 {
        return UInt16(strtoul(self, nil, 2))
    }
    /// 2进制转16进制, UInt16
    internal var u16BinaryToHex: String {
        return u16BinaryToDecimal.hex
    }
    /// 字符串转数据, 非有损转换
    internal func toData(_ aString: String, encoding: String.Encoding) -> Data? {
        return aString.data(using: encoding, allowLossyConversion: false)
    }
    /// 字符串转 UTF8 数据, 非有损转换
    var utf8Data: Data? {
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
    /// 字符串转数据
    var data: Data {
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


// MARK: - NSMutableAttributedString
extension NSMutableAttributedString {
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
















