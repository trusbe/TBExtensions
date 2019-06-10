//
//  TBUtils.swift
//  TBExtensions
//
//  Created by TrusBe on 2018/7/10.
//  Copyright © 2018年 TrusBe. All rights reserved.
//

import Foundation

public enum Bit: UInt8, CustomStringConvertible {
    case zero, one
    
    public var description: String {
        switch self {
        case .one:
            return "1"
        case .zero:
            return "0"
        }
    }
}

public class TBUtils: NSObject {
    /// Byte 转 Bit 数组
    public static func bits(fromByte byte: UInt8) -> [Bit] {
        var byte = byte
        var bits = [Bit](repeating: .zero, count: 8)
        for i in 0..<8 {
            let currentBit = byte & 0x01
            if currentBit != 0 {
                bits[i] = .one
            }
            byte >>= 1
        }
        return bits
    }
}
