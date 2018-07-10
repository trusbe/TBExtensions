//
//  TBData.swift
//  TBExtensions
//
//  Created by xuntong on 2018/7/10.
//  Copyright © 2018年 TrusBe. All rights reserved.
//

import Foundation

extension Data {
    
    /// 数据转换成任意格式的字符串
    func string(as encoding: String.Encoding) -> String! {
        return String(data: self, encoding: encoding)
    }

    /// 数据转换成 UTF8 编码字符串
    internal var utf8String: String? {
        return string(as: .utf8)
    }
    
    /// 数据转十六进制字符串
    internal var hexString: String {
        let pointer = self.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> UnsafePointer<UInt8> in
            return bytes
        }
        let array = getByteArray(pointer)
        
        return array.reduce("") { (result, byte) -> String in
            result + String(format: "%02x", byte)
        }
    }
    
    private func getByteArray(_ pointer: UnsafePointer<UInt8>) -> [UInt8] {
        let buffer = UnsafeBufferPointer<UInt8>(start: pointer, count: count)
        return [UInt8](buffer)
    }
    
    /// 数据转字节数组
    internal var bytes:[UInt8] {
        return withUnsafeBytes {
            [UInt8](UnsafeBufferPointer(start: $0, count: count))
        }
    }
    
    /// 随机生成指定数量的数据
    internal static func dataWithNumberOfBytes(_ numberOfBytes: Int) -> Data {
        let bytes = malloc(numberOfBytes)
        let data = Data(bytes: bytes!, count: numberOfBytes)
        free(bytes)
        return data
    }
}



