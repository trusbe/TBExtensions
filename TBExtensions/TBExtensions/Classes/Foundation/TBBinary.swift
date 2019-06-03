//
//  TBBinary.swift
//  TBExtensions
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 TrusBe. All rights reserved.
//

import Foundation

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
