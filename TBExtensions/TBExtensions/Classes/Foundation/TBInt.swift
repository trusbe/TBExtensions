//
//  TBInt.swift
//  TBExtensions
//
//  Created by TrusBe on 2018/7/10.
//  Copyright © 2018年 TrusBe. All rights reserved.
//

import Foundation

// MARK: - Int8
public extension Int8 {
    init?(hex: String) {
        guard hex.count == 2, let value = UInt8(hex, radix: 16) else {
            return nil
        }
        self = Int8(bitPattern: value)
    }
    
    /// Data to Int8
    init(data: Data) {
        self = data.withUnsafeBytes { $0.load(as: Int8.self) }
    }
    
    var hex: String {
        // This is to ensure that even negative numbers are printed with length 2.
        return String(String(format: "%02X", self).suffix(2))
    }

    /// Int8 to Data
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int8>.size)
    }
}


// MARK: - Int16
public extension Int16 {
    init?(hex: String) {
        guard hex.count == 4, let value = UInt16(hex, radix: 16) else {
            return nil
        }
        self = Int16(bitPattern: value)
    }

    /// Data to Int16 littleEndian
    init(data: Data) {
        self = data.withUnsafeBytes { $0.load(as: Int16.self) }
    }
    
    var hex: String {
        // This is to ensure that even negative numbers are printed with length 4.
        return String(String(format: "%04X", self).suffix(4))
    }

    /// Int16 to Data
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int16>.size)
    }
    
    /// Data with endian to Int16
    init(data: Data, bigEndian: Bool) {
        let value = data.withUnsafeBytes { $0.load(as: Int16.self) }
        self = bigEndian ? value.bigEndian : value.littleEndian
    }
}


// MARK: - Int32
public extension Int32 {
    init?(hex: String) {
        guard hex.count == 8, let value = UInt32(hex, radix: 16) else {
            return nil
        }
        self = Int32(bitPattern: value)
    }

    /// Data to Int32 littleEndian
    init(data: Data) {
        self = data.withUnsafeBytes { $0.load(as: Int32.self) }
    }
    
    var hex: String {
        return String(format: "%08X", self)
    }

    /// UInt32 to Data
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int32>.size)
    }

    /// Data with endian to Int32
    init(data: Data, bigEndian: Bool) {
        let value = data.withUnsafeBytes { $0.load(as: Int32.self) }
        self = bigEndian ? value.bigEndian : value.littleEndian
    }
}


// MARK: - Int64
public extension Int64 {
    // 待测试
    init?(hex: String) {
        guard hex.count == 16, let value = UInt64(hex, radix: 16) else {
            return nil
        }
        self = Int64(bitPattern: value)
    }

    /// Data to Int64 littleEndian
    init(data: Data) {
        self = data.withUnsafeBytes { $0.load(as: Int64.self) }
    }
    
    // 待测试
    var hex: String {
        return String(format: "%08X", self)
    }
    
    /// Int64 to Data
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int64>.size)
    }
}
