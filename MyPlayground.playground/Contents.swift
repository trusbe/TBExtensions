//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

public func logger(with title: String, subTitle: String, info: String?) {
    if info == nil {
        print("【\(title)】, \(subTitle)")
    } else {
        print("【\(title)】, \(subTitle), \(info!)")
    }
}

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
}


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




/// MARK: - TEST
let hex8 = "FE"
let value8: UInt8 = 254
UInt8(data: Data([0xfe]))
value8.hex
value8.binary
value8.data.hex



let hex16 = "FFFE"
let value16: UInt16 = 65534
UInt16(hex: hex16)
value16.hex
value16.binary
value16.bigEndian.data.hex
value16.littleEndian.data.hex
UInt16(data: Data([0xFF, 0xFE]), bigEndian: true)
UInt16(data: Data([0xFF, 0xFE]), bigEndian: false)



let hex32 = "FFFFFFFE"
let value32: UInt32 = 4294967294
UInt32(hex: hex32)
value32.hex
value32.binary
value32.bigEndian.data.hex
value32.littleEndian.data.hex
UInt32(data: Data([0xFF, 0xFF, 0xFF, 0xFE]), bigEndian: true)
UInt32(data: Data([0xFF, 0xFF, 0xFF, 0xFE]), bigEndian: false)
value32.byteArrayBigEndian



let hex64 = "FFFFFFFFFFFFFFFE"
let value64: UInt64 = 9223372036854775807
UInt64(hex: hex64)
value64.hex
value64.binary
value64.bigEndian.data.hex
value64.littleEndian.data.hex




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

// MARK: - TEST
let str = "FE"
str.u8HexToDecimal
str.u8HexToBinary

let binary = "11101111"
binary.u8BinaryToDecimal
binary.u8BinaryToHex

let str16 = "FFFE"
str16.u16HexToDecimal
str16.u16HexToBinary

let binary16 = "1111111111111110"
binary16.u16BinaryToDecimal
binary16.u16BinaryToHex


let strL = "FFFFFFFFFFFFFE"
strL.utf8Data?.hex
strL.bytes
strL.data.hex


















