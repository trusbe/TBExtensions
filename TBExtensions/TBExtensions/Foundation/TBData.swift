//
//  TBData.swift
//  TBExtensions
//
//  Created by TrusBe on 2018/7/10.
//  Copyright © 2018年 TrusBe. All rights reserved.
//

import Foundation

// MARK: - Init
extension Data {
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

    
    
    
    
//    /// Creates an Data instace based on a hex string (example: "ffff" would be <FF FF>).
//    ///
//    /// - parameter hex: The hex string without any spaces; should only have [0-9A-Fa-f].
//    init?(hex: String) {
//        if hex.count % 2 != 0 {
//            return nil
//        }
//        let hexArray = Array(hex)
//        var bytes: [UInt8] = []
//
//        for index in stride(from: 0, to: hexArray.count, by: 2) {
//            guard let byte = UInt8("\(hexArray[index])\(hexArray[index + 1])", radix: 16) else {
//                return nil
//            }
//            bytes.append(byte)
//        }
//        self.init(bytes: bytes, count: bytes.count)
//    }
//}
//
//
//// MARK: - Properties
//extension Data {
//    /// 数据转换成 UTF8 编码字符串
//    internal var tb_utf8String: String? {
//        return tb_string(as: .utf8)
//    }
//
//    /// 数据转十六进制字符串
//    internal var tb_hexString: String {
//        let pointer = self.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> UnsafePointer<UInt8> in
//            return bytes
//        }
//        let array = tb_getByteArray(pointer)
//        return array.reduce("") { (result, byte) -> String in
//            result + String(format: "%02x", byte)
//        }
//    }
//
//    private func tb_getByteArray(_ pointer: UnsafePointer<UInt8>) -> [UInt8] {
//        let buffer = UnsafeBufferPointer<UInt8>(start: pointer, count: count)
//        return [UInt8](buffer)
//    }
//
//    /// 数据转字节数组
//    internal var tb_bytes:[UInt8] {
//        return withUnsafeBytes {
//            [UInt8](UnsafeBufferPointer(start: $0, count: count))
//        }
//    }
//}
//
//
//// MARK: - Methods
//extension Data {
//    /// 数据转换成任意格式的字符串
//    func tb_string(as encoding: String.Encoding) -> String! {
//        return String(data: self, encoding: encoding)
//    }
//
//    /// 随机生成指定数量的数据
//    internal static func tb_dataWithNumberOfBytes(_ numberOfBytes: Int) -> Data {
//        let bytes = malloc(numberOfBytes)
//        let data = Data(bytes: bytes!, count: numberOfBytes)
//        free(bytes)
//        return data
//    }
//
//    /// Gets one byte from the given index.
//    ///
//    /// - parameter index: The index of the byte to be retrieved. Note that this should never be >= length.
//    ///
//    /// - returns: The byte located at position `index`.
//    func tb_getByte(at index: Int) -> Int8 {
//        let data: Int8 = self.subdata(in: index ..< (index + 1)).withUnsafeBytes { $0.pointee }
//        return data
//    }
//
//    /// Gets an unsigned int (32 bits => 4 bytes) from the given index.
//    ///
//    /// - parameter index: The index of the uint to be retrieved. Note that this should never be >= length -
//    ///                    3.
//    ///
//    /// - returns: The unsigned int located at position `index`.
//    func tb_getUnsignedInteger(at index: Int, bigEndian: Bool = true) -> UInt32 {
//        let data: UInt32 =  self.subdata(in: index ..< (index + 4)).withUnsafeBytes { $0.pointee }
//        return bigEndian ? data.bigEndian : data.littleEndian
//    }
//
//    /// Gets an unsigned long integer (64 bits => 8 bytes) from the given index.
//    ///
//    /// - parameter index: The index of the ulong to be retrieved. Note that this should never be >= length -
//    ///                    7.
//    ///
//    /// - returns: The unsigned long integer located at position `index`.
//    func tb_getUnsignedLong(at index: Int, bigEndian: Bool = true) -> UInt64 {
//        let data: UInt64 = self.subdata(in: index ..< (index + 8)).withUnsafeBytes { $0.pointee }
//        return bigEndian ? data.bigEndian : data.littleEndian
//    }
//
//    /// Appends the given byte (8 bits) into the receiver Data.
//    ///
//    /// - parameter data: The byte to be appended.
//    mutating func tb_append(byte data: Int8) {
//        var data = data
//        self.append(UnsafeBufferPointer(start: &data, count: 1))
//    }
//
//    /// Appends the given unsigned integer (32 bits; 4 bytes) into the receiver Data.
//    ///
//    /// - parameter data: The unsigned integer to be appended.
//    mutating func tb_append(unsignedInteger data: UInt32, bigEndian: Bool = true) {
//        var data = bigEndian ? data.bigEndian : data.littleEndian
//        self.append(UnsafeBufferPointer(start: &data, count: 1))
//    }
//
//    /// Appends the given unsigned long (64 bits; 8 bytes) into the receiver Data.
//    ///
//    /// - parameter data: The unsigned long to be appended.
//    mutating func tb_append(unsignedLong data: UInt64, bigEndian: Bool = true) {
//        var data = bigEndian ? data.bigEndian : data.littleEndian
//        self.append(UnsafeBufferPointer(start: &data, count: 1))
//    }
//
//    struct HexEncodingOptions: OptionSet {
//        let rawValue: Int
//        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
//    }
//
//    func tb_hexEncodedString(options: HexEncodingOptions = []) -> String {
//        let hexDigits = Array((options.contains(.upperCase) ? "0123456789ABCDEF" : "0123456789abcdef").utf16)
//        var chars: [unichar] = []
//        chars.reserveCapacity(2 * count)
//        for byte in self {
//            chars.append(hexDigits[Int(byte / 16)])
//            chars.append(hexDigits[Int(byte % 16)])
//        }
//        return String(utf16CodeUnits: chars, count: chars.count)
//    }
//}
//
//extension Data {
//    var uint8: UInt8 {
//        get {
//            var number: UInt8 = 0
//            self.copyBytes(to:&number, count: MemoryLayout<UInt8>.size)
//            return number
//        }
//    }
//
//    var uint16: UInt16 {
//        get {
//            let i16array = self.withUnsafeBytes {
//                UnsafeBufferPointer<UInt16>(start: $0, count: self.count/2).map(UInt16.init(littleEndian:))
//            }
//            return i16array[0]
//        }
//    }
//
//    var uint32: UInt32 {
//        get {
//            let i32array = self.withUnsafeBytes {
//                UnsafeBufferPointer<UInt32>(start: $0, count: self.count/2).map(UInt32.init(littleEndian:))
//            }
//            return i32array[0]
//        }
//    }
//
//    var uuid: NSUUID? {
//        get {
//            var bytes = [UInt8](repeating: 0, count: self.count)
//            self.copyBytes(to:&bytes, count: self.count * MemoryLayout<UInt32>.size)
//            return NSUUID(uuidBytes: bytes)
//        }
//    }
//    var stringASCII: String? {
//        get {
//            return NSString(data: self, encoding: String.Encoding.ascii.rawValue) as String?
//        }
//    }
//
//    var stringUTF8: String? {
//        get {
//            return NSString(data: self, encoding: String.Encoding.utf8.rawValue) as String?
//        }
//    }
//
//    struct HexEncodingOptions: OptionSet {
//        let rawValue: Int
//        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
//    }
//
//    func hexEncodedString(options: HexEncodingOptions = []) -> String {
//        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
//        return map { String(format: format, $0) }.joined()
//    }
}









