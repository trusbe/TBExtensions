//
//  TBBit.swift
//  TBExtensions
//
//  Created by mac on 2021/6/7.
//  Copyright © 2021 TrusBe. All rights reserved.
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

public extension Bit {
    /// Byte 转 Bit 数组
    func bits(fromByte byte: UInt8) -> [Bit] {
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
