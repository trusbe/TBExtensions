//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

// MARK: - Logger
public func logger(with title: String, subTitle: String, info: String?) {
    if info == nil {
        print("【\(title)】, \(subTitle)")
    } else {
        print("【\(title)】, \(subTitle), \(info!)")
    }
}

// MARK: - TBBinary
public struct TBBinary {
    public let bytes: [UInt8]
    public var readingOffset: Int = 0
    // 字节数组转 TBBinary
    public init(bytes: [UInt8]) {
        self.bytes = bytes
    }
    // Data 转 TBBinary
    public init(data: Data) {
        let bytesLength = data.count
        var bytesArray  = [UInt8](repeating: 0, count: bytesLength)
        (data as NSData).getBytes(&bytesArray, length: bytesLength)
        self.bytes      = bytesArray
    }
    /// 获取某字节指定位的数据，输出 Int 型
    public func bit(_ position: Int) -> Int {
        let byteSize        = 8
        let bytePosition    = position / byteSize
        let bitPosition     = 7 - (position % byteSize)
        let byte            = self.byte(bytePosition)
        return (byte >> bitPosition) & 0x01
    }
    /// 截取某字节指定长度的位数据转成 Int型
    public func bits(_ range: Range<Int>) -> Int {
        var positions = [Int]()
        
        for position in range.lowerBound..<range.upperBound {
            positions.append(position)
        }
        
        return positions.reversed().enumerated().reduce(0) {
            $0 + (bit($1.element) << $1.offset)
        }
    }
    /// 截取某字节指定长度的位数据转成 Int型
    public func bits(_ start: Int, _ length: Int) -> Int {
        return self.bits(start..<(start + length))
    }
    /// 获取指定位置的字节转成 Int 型输出
    public func byte(_ position: Int) -> Int {
        return Int(self.bytes[position])
    }
    /// 截取指定长度的字节数组
    public func bytes(_ start: Int, _ length: Int) -> [UInt8] {
        return Array(self.bytes[start..<start+length])
    }
    /// 截取指定长度字节转换成 Int 型
    public func bytesToInt(_ start: Int, _ length: Int) -> Int {
        return bits(start*8, length*8)
    }
    /// 是否支持指定长度的位偏移
    public func bitsWithInternalOffsetAvailable(_ length: Int) -> Bool {
        return (self.bytes.count * 8) >= (self.readingOffset + length)
    }
    /// 从左到右截取指定长度位数据，输出 Int 型
    public mutating func next(bits length: Int) -> Int {
        if self.bitsWithInternalOffsetAvailable(length) {
            let returnValue = self.bits(self.readingOffset, length)
            self.readingOffset = self.readingOffset + length
            return returnValue
        } else {
            fatalError("Couldn't extract Bits.")
        }
    }
    /// 是否支持指定长度的字节偏移
    public func bytesWithInternalOffsetAvailable(_ length: Int) -> Bool {
        let availableBits = self.bytes.count * 8
        let requestedBits = readingOffset + (length * 8)
        let possible      = availableBits >= requestedBits
        return possible
    }
    /// 从左到右截取指定长度字节数据，输出字节数组
    public mutating func next(bytes length: Int) -> [UInt8] {
        if bytesWithInternalOffsetAvailable(length) {
            let returnValue = self.bytes[(self.readingOffset / 8)..<((self.readingOffset / 8) + length)]
            self.readingOffset = self.readingOffset + (length * 8)
            return Array(returnValue)
        } else {
            fatalError("Couldn't extract Bytes.")
        }
    }
}

// MARK: - TEST
let data = Data([0xff, 0x30, 0x31, 0x32, 0x33])
var info1 = TBBinary.init(bytes: [0xff])
var info2 = TBBinary.init(data: data)

logger(with: "TBBinary", subTitle: "init", info: "\(info1)")
info1.bit(3)
info1.bits(0..<4)
info1.bits(0, 4)
info2.byte(2)
info2.bytes(0, 4)
info2.bytesToInt(0, 4)
info1.bitsWithInternalOffsetAvailable(8)
let info3 = info1.next(bits: 2)
info2.bytesWithInternalOffsetAvailable(5)
let info4 = info2.next(bytes: 3)



// MARK: - GCDTimer

/// GCD定时器倒计时⏳
/// - interval: 循环间隔时间
/// - repeatCount: 重复次数
/// - handler: 循环事件, 闭包参数： 1. timer， 2. 剩余执行次数
public func dispatchTimer(interval: Double, repeatCount:Int, handler:@escaping (DispatchSourceTimer?, Int)->()) {
    if repeatCount <= 0 {
        return
    }
    let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    var count = repeatCount
    timer.schedule(wallDeadline: .now(), repeating: interval)
    timer.setEventHandler(handler: {
        count -= 1
        DispatchQueue.main.async {
            handler(timer, count)
        }
        if count == 0 {
            timer.cancel()
        }
    })
    timer.resume()
}

/// GCD定时器循环操作
/// - interval: 循环间隔时间
/// - handler: 循环事件
public func dispatchTimer(repeatInterval: Double, handler:@escaping (DispatchSourceTimer?)->()) {
    let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    timer.schedule(deadline: .now(), repeating: repeatInterval)
    timer.setEventHandler {
        DispatchQueue.main.async {
            handler(timer)
        }
    }
    timer.resume()
}

/// GCD延时操作
/// - after: 延迟的时间
/// - handler: 事件
public func dispatchAfter(after: Double, handler:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
        handler()
    }
}

// MARK: - TEST

dispatchTimer(interval: 1, repeatCount: 4) { (timer, count) in
    switch count {
    case 3:
        logger(with: "Playground", subTitle: "循环", info: "Count:\(count), Date:\(Date())")
//        dispatchTimer(repeatInterval: 2) { (timer) in
//            logger(with: "Playground", subTitle: "定时2秒后", info: "\(Date())")
//        }
    case 2:
        logger(with: "Playground", subTitle: "循环", info: "Count:\(count), Date:\(Date())")
    case 1:
        logger(with: "Playground", subTitle: "循环", info: "Count:\(count), Date:\(Date())")
    default:
        logger(with: "Playground", subTitle: "循环", info: "Count:\(count), Date:\(Date())")
        dispatchAfter(after: 1) {
            logger(with: "Playground", subTitle: "延迟1秒", info: "\(Date())")
            
        }
    }
}


// MARK: - Data
extension Data {
    /// Hex string to Data representation
    /// Inspired by https://stackoverflow.com/questions/26501276/converting-hex-string-to-nsdata-in-swift
    public init?(hex: String) {
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
    public var hex: String {
        return map { String(format: "%02X", $0) }.joined()
    }
    /// 数据转换成任意格式的字符串
    public func toString(as encoding: String.Encoding) -> String! {
        return String(data: self, encoding: encoding)
    }
    /// 数据转换成 UTF8 编码字符串
    public var utf8String: String? {
        return toString(as: .utf8)
    }
    /// 获取数据字节数组
    private func getByteArray(_ pointer: UnsafePointer<UInt8>) -> [UInt8] {
        let buffer = UnsafeBufferPointer<UInt8>(start: pointer, count: count)
        return [UInt8](buffer)
    }
    /// 随机生成指定数量的数据
    public static func randomData(length: Int) -> Data {
        let bytes = malloc(length)
        let data = Data(bytes: bytes!, count: length)
        free(bytes)
        return data
    }
    /// Data to Int8
    public var int8: Int8 {
        get {
            return Int8(bitPattern: self[0])
        }
    }
    /// Data to Int16, littleEndian
    public var int16Little: Int16 {
        get {
            #if swift(>=5.0)
            return Int16(littleEndian: self.withUnsafeBytes { $0.load(as: Int16.self) })
            #else
            return Int16(littleEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    /// Data to Int32, littleEndian
    public var int32Little: Int32 {
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
    public var uint8: UInt8 {
        get {
            var number: UInt8 = 0
            self.copyBytes(to:&number, count: MemoryLayout<UInt8>.size)
            return number
        }
    }
    /// Data to UInt16, littleEndian
    public var uint16Little: UInt16 {
        get {
            #if swift(>=5.0)
            return UInt16(littleEndian: self.withUnsafeBytes { $0.load(as: UInt16.self) })
            #else
            return UInt16(littleEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    /// Data to UInt32, littleEndian
    public var uint32Little: UInt32 {
        get {
            #if swift(>=5.0)
            return UInt32(littleEndian: self.withUnsafeBytes { $0.load(as: UInt32.self) })
            #else
            return UInt32(littleEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    /// Data to UInt64, littleEndian
    private var uint64Little: UInt64 {
        get {
            #if swift(>=5.0)
            return UInt64(littleEndian: self.withUnsafeBytes { $0.load(as: UInt64.self) })
            #else
            return UInt64(littleEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    /// Data to Int16, bigEndian
    public var int16Big: Int16 {
        get {
            #if swift(>=5.0)
            return Int16(bigEndian: self.withUnsafeBytes { $0.load(as: Int16.self) })
            #else
            return Int16(bigEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    /// Data to Int32, bigEndian
    public var int32Big: Int32 {
        get {
            #if swift(>=5.0)
            return Int32(bigEndian: self.withUnsafeBytes { $0.load(as: Int32.self) })
            #else
            return Int32(bigEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    /// Data to Int64, bigEndian
    private var int64Big: Int64 {
        get {
            #if swift(>=5.0)
            return Int64(bigEndian: self.withUnsafeBytes { $0.load(as: Int64.self) })
            #else
            return Int64(bigEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    /// Data to UInt16, bigEndian
    public var uint16Big: UInt16 {
        get {
            #if swift(>=5.0)
            return UInt16(bigEndian: self.withUnsafeBytes { $0.load(as: UInt16.self) })
            #else
            return UInt16(bigEndian: self.withUnsafeBytes { $0.pointee })
            #endif
        }
    }
    /// Data to UInt32, bigEndian
    public var uint32Big: UInt32 {
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





/// MARK: - TEST Data
let  dataStr = "FFFE"
let data = Data(hex: dataStr)
data?.hex
let data1 = Data([0x7f, 0x32, 0x33, 0x34])
data1.toString(as: .utf8)
data1.utf8String
data1.byte(at: 0)
data1.bytes()


let rData = Data.randomData(length: 5)
rData.hex
let index1 = Data([0x7f])
let index2 = Data([0x7f, 0x7f])
let index3 = Data([0x7f, 0x7f, 0x7f, 0x7f])
let index4 = Data([0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f])

index1.int8
index2.int16Little
index3.int32Little
//index4.int64Little

index1.uint8
index2.uint16Little
index3.uint32Little
//index4.uint64Little

index2.int16Big
index3.int32Big
//index4.int64Big

index2.uint16Big
index3.uint32Big
//index4.uint64Big




// MARK: - UInt
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


















