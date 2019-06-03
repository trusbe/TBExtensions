//
//  TBUInt.swift
//  TBExtensions
//
//  Created by mac on 2019/5/29.
//  Copyright © 2019 TrusBe. All rights reserved.
//

import Foundation


// MARK: - UInt8
extension UInt8 {
    /// Data to UInt8
    init(data: Data) {
        self = data.withUnsafeBytes { $0.load(as: UInt8.self) }
    }
    /// UInt8 to Hex String
    var hex: String {
        return String(format: "%02X", self)
    }
    /// UInt8 to Binary String
    var binary: String {
        return String(self, radix: 2, uppercase: true)
    }
    /// UInt8 to Data
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt8>.size)
    }
}


// MARK: - UInt16
extension UInt16 {
    /// Hex String to UInt16
    init?(hex: String) {
        guard hex.count == 4, let value = UInt16(hex, radix: 16) else {
            return nil
        }
        self = value
    }
    /// UInt16 to Hex String
    var hex: String {
        return String(format: "%04X", self)
    }
    /// Data to UInt16 littleEndian
    init(data: Data) {
        self = data.withUnsafeBytes { $0.load(as: UInt16.self) }
    }
    /// Data with endian to UInt16
    init(data: Data, bigEndian: Bool) {
        let value = data.withUnsafeBytes { $0.load(as: UInt16.self) }
        self = bigEndian ? value.bigEndian : value.littleEndian
    }
    /// UInt8 to Binary String
    var binary: String {
        return String(self, radix: 2, uppercase: true)
    }
    /// UInt16 to Data
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt16>.size)
    }
}


// MARK: - UInt32
extension UInt32 {
    /// Hex String to UInt32
    init?(hex: String) {
        guard hex.count == 8, let value = UInt32(hex, radix: 16) else {
            return nil
        }
        self = value
    }
    /// UInt32 to Hex String
    var hex: String {
        return String(format: "%08X", self)
    }
    /// Data to UInt32 littleEndian
    init(data: Data) {
        self = data.withUnsafeBytes { $0.load(as: UInt32.self) }
    }
    /// Data with endian to UInt32
    init(data: Data, bigEndian: Bool) {
        let value = data.withUnsafeBytes { $0.load(as: UInt32.self) }
        self = bigEndian ? value.bigEndian : value.littleEndian
    }
    /// UInt32 to Binary String
    var binary: String {
        return String(self, radix: 2, uppercase: true)
    }
    /// UInt32 to Data
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt32>.size)
    }
    /// UInt32 to Byte Array bigEndian
    var byteArrayBigEndian: [UInt8] {
        return [
            UInt8((self & 0xFF000000) >> 24),
            UInt8((self & 0x00FF0000) >> 16),
            UInt8((self & 0x0000FF00) >> 8),
            UInt8(self & 0x000000FF)
        ]
    }
}


// MARK: - UInt64
extension UInt64 {
    /// Hex String to UInt64
    init?(hex: String) {
        guard hex.count == 16, let value = UInt64(hex, radix: 16) else {
            return nil
        }
        self = value
    }
    /// UInt64 to Hex String
    var hex: String {
        return String(format: "%08X", self)
    }
    /// UInt64 to Binary String
    var binary: String {
        return String(self, radix: 2, uppercase: true)
    }
    
    /// UInt64 to Data
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt64>.size)
    }
}
