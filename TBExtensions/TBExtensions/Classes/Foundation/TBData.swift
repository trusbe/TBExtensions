//
//  TBData.swift
//  TBExtensions
//
//  Created by TrusBe on 2018/7/10.
//  Copyright © 2018年 TrusBe. All rights reserved.
//

import Foundation

// MARK: - Init
public extension Data {
    /// Hex string to Data representation
    /// Inspired by https://stackoverflow.com/questions/26501276/converting-hex-string-to-nsdata-in-swift
    init?(hex: String) {
        guard hex.count % 2 == 0 else {
            return nil
        }
        let len = hex.count / 2
        var data = Data(capacity: len)
        
        for i in 0..<len {
            let j = hex.index(hex.startIndex, offsetBy: i * 2)
            let k = hex.index(j, offsetBy: 2)
            let bytes = hex[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
    
    /// Hexadecimal string representation of `Data` object.
    var hex: String {
        return map { String(format: "%02X", $0) }.joined()
    }

    /// 数据转换成任意格式的字符串
    func toString(as encoding: String.Encoding) -> String! {
        return String(data: self, encoding: encoding)
    }
    
    /// 数据转换成 UTF8 编码字符串
    var utf8String: String? {
        return toString(as: .utf8)
    }
    
    /// 获取数据字节数组
    private func getByteArray(_ pointer: UnsafePointer<UInt8>) -> [UInt8] {
        let buffer = UnsafeBufferPointer<UInt8>(start: pointer, count: count)
        return [UInt8](buffer)
    }
    
    /// 随机生成指定数量的数据
    static func randomData(length: Int) -> Data {
        let bytes = malloc(length)
        let data = Data(bytes: bytes!, count: length)
        free(bytes)
        return data
    }
    
    /// Data to Int8
    var int8: Int8 {
        get {
            return Int8(bitPattern: self[0])
        }
    }
    
    /// Data to Int16, littleEndian
    var int16Little: Int16 {
        get {
            #if swift(>=5.0)
            return Int16(littleEndian: self.withUnsafeBytes { $0.load(as: Int16.self) })
            #else
            return Int16(littleEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    
    /// Data to Int32, littleEndian
    var int32Little: Int32 {
        get {
            #if swift(>=5.0)
            return Int32(littleEndian: self.withUnsafeBytes { $0.load(as: Int32.self) })
            #else
            return Int32(littleEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    
    /// Data to Int64, littleEndian
    private var int64Little: Int64 {
        get {
            #if swift(>=5.0)
            return Int64(littleEndian: self.withUnsafeBytes { $0.load(as: Int64.self) })
            #else
            return Int64(littleEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    
    /// Data to UInt8
    var uint8: UInt8 {
        get {
            var number: UInt8 = 0
            self.copyBytes(to:&number, count: MemoryLayout<UInt8>.size)
            return number
        }
    }
    
    /// Data to UInt16, littleEndian
    var uint16Little: UInt16 {
        get {
            #if swift(>=5.0)
            return UInt16(littleEndian: self.withUnsafeBytes { $0.load(as: UInt16.self) })
            #else
            return UInt16(littleEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    
    /// Data to UInt32, littleEndian
    var uint32Little: UInt32 {
        get {
            #if swift(>=5.0)
            return UInt32(littleEndian: self.withUnsafeBytes { $0.load(as: UInt32.self) })
            #else
            return UInt32(littleEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    
    /// Data to UInt64, littleEndian
    var uint64Little: UInt64 {
        get {
            #if swift(>=5.0)
            return UInt64(littleEndian: self.withUnsafeBytes { $0.load(as: UInt64.self) })
            #else
            return UInt64(littleEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    
    /// Data to Int16, bigEndian
    var int16Big: Int16 {
        get {
            #if swift(>=5.0)
            return Int16(bigEndian: self.withUnsafeBytes { $0.load(as: Int16.self) })
            #else
            return Int16(bigEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    
    /// Data to Int32, bigEndian
    var int32Big: Int32 {
        get {
            #if swift(>=5.0)
            return Int32(bigEndian: self.withUnsafeBytes { $0.load(as: Int32.self) })
            #else
            return Int32(bigEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    
    /// Data to Int64, bigEndian
    var int64Big: Int64 {
        get {
            #if swift(>=5.0)
            return Int64(bigEndian: self.withUnsafeBytes { $0.load(as: Int64.self) })
            #else
            return Int64(bigEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    
    /// Data to UInt16, bigEndian
    var uint16Big: UInt16 {
        get {
            #if swift(>=5.0)
            return UInt16(bigEndian: self.withUnsafeBytes { $0.load(as: UInt16.self) })
            #else
            return UInt16(bigEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    
    /// Data to UInt32, bigEndian
    var uint32Big: UInt32 {
        get {
            #if swift(>=5.0)
            return UInt32(bigEndian: self.withUnsafeBytes { $0.load(as: UInt32.self) })
            #else
            return UInt32(bigEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    
    /// Data to UInt64, bigEndian
    private var uint64Big: UInt64 {
        get {
            #if swift(>=5.0)
            return UInt64(bigEndian: self.withUnsafeBytes { $0.load(as: UInt64.self) })
            #else
            return UInt64(bigEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    
    /// 获取某一个字节的 UInt8 类型
    func byte(at index: Int) -> UInt8 {
        let data: UInt8 = self.subdata(in: index ..< (index + 1)).uint8
        return data
    }
    
    /// Data to Byte Array
    func bytes() -> [UInt8] {
        // let count = MemoryLayout.size(ofValue: self)
        let count = self.count
        var copyOfSelf = self
        let data = withUnsafePointer(to: &copyOfSelf) {
            $0.withMemoryRebound(to: UInt8.self, capacity: count, {
                UnsafeBufferPointer(start: $0, count: count)
            })
        }
        return Array(data)
    }
}


extension Data {
    // Inspired by: https://stackoverflow.com/a/38024025/2115352

    /// Converts the required number of bytes, starting from `offset`
    /// to the value of return type.
    ///
    /// - parameter offset: The offset from where the bytes are to be read.
    /// - returns: The value of type of the return type.
    func read<R: FixedWidthInteger>(fromOffset offset: Int = 0) -> R {
        let length = MemoryLayout<R>.size
        
        #if swift(>=5.0)
        return subdata(in: offset ..< offset + length).withUnsafeBytes { $0.load(as: R.self) }
        #else
        return subdata(in: offset ..< offset + length).withUnsafeBytes { $0.pointee }
        #endif
    }
    
    func readUInt24(fromOffset offset: Int = 0) -> UInt32 {
        return UInt32(self[offset]) | UInt32(self[offset + 1]) << 8 | UInt32(self[offset + 2]) << 16
    }
    
    func readBigEndian<R: FixedWidthInteger>(fromOffset offset: Int = 0) -> R {
        let r: R = read(fromOffset: offset)
        return r.bigEndian
    }
}


// Source: http://stackoverflow.com/a/42241894/2115352
protocol DataConvertible {
    static func + (lhs: Data, rhs: Self) -> Data
    static func += (lhs: inout Data, rhs: Self)
}


extension DataConvertible {
    static func + (lhs: Data, rhs: Self) -> Data {
        var value = rhs
        let data = withUnsafePointer(to: &value) { pointer -> Data in
            return Data(buffer: UnsafeBufferPointer(start: pointer, count: 1))
        }
        return lhs + data
    }
    
    static func += (lhs: inout Data, rhs: Self) {
        lhs = lhs + rhs
    }
}

extension UInt8  : DataConvertible { }
extension UInt16 : DataConvertible { }
extension UInt32 : DataConvertible { }
extension UInt64 : DataConvertible { }
extension Int8   : DataConvertible { }
extension Int16  : DataConvertible { }
extension Int32  : DataConvertible { }
extension Int64  : DataConvertible { }
extension Int    : DataConvertible { }
extension UInt   : DataConvertible { }
extension Float  : DataConvertible { }
extension Double : DataConvertible { }


extension String : DataConvertible {
    static func + (lhs: Data, rhs: String) -> Data {
        guard let data = rhs.data(using: .utf8) else { return lhs }
        return lhs + data
    }
}


extension Data : DataConvertible {
    static func + (lhs: Data, rhs: Data) -> Data {
        var data = Data()
        data.append(lhs)
        data.append(rhs)
        return data
    }
    
    static func + (lhs: Data, rhs: Data?) -> Data {
        guard let rhs = rhs else {
            return lhs
        }
        var data = Data()
        data.append(lhs)
        data.append(rhs)
        return data
    }
}


extension Bool : DataConvertible {
    
    static func + (lhs: Data, rhs: Bool) -> Data {
        if rhs {
            return lhs + UInt8(0x01)
        } else {
            return lhs + UInt8(0x00)
        }
    }
}
