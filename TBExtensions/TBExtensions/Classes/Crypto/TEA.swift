//
//  TEA.swift
//  TBExtensions
//
//  Created by mac on 2021/6/7.
//  Copyright © 2021 TrusBe. All rights reserved.
//

import Foundation

/**
 TEA
 */
public class TEA {
    
    /// 加解密位数 0~7 原型 (1<<number)
    fileprivate let number: UInt32
    /// 加解密KEY
    fileprivate let key: (UInt32,UInt32,UInt32,UInt32)
    
    /**
     初始化
     - parameter    number:     加解密位数 0~7 原型 (1<<number)
     - parameter    key:        加解密KEY
     */
    public init(_ number: UInt32, key: (UInt32,UInt32,UInt32,UInt32)) {
        
        self.number = number
        self.key = key
    }
    
    // MARK: Data Crypt
    
    /**
     加密
     - parameter    data:   数据
     */
    public func encrypt(_ data: Data) -> Data {
        
        var encryptData = data
        encryptData.encrypt(self)
        
        return encryptData
    }
    
    /**
     解密
     - parameter    data:   数据
     */
    public func decrypt(_ data: Data) -> Data {
        
        var decryptData = data
        decryptData.decrypt(self)
        
        return decryptData
    }
    
    // MARK: File Crypt
    /**
     加密
     - parameter    filePath:       文件路径
     - parameter    outFilePath:    输出加密文件路径
     */
    public func encrypt(_ filePath: String, outFilePath: String) {
        
        if FileManager.default.createFile(outFilePath),
            let readFile = FileHandle.init(forReadingAtPath: filePath),
            let writeFile = FileHandle.init(forWritingAtPath: outFilePath) {
            
            readFile.encrypt(self, outFile: writeFile)
            
            readFile.closeFile()
            writeFile.closeFile()
        }
    }
    
    /**
     解密
     - parameter    filePath:       文件路径
     - parameter    outFilePath:    输出解密文件路径
     */
    public func decrypt(_ filePath: String, outFilePath: String) {
        
        if FileManager.default.createFile(outFilePath),
            let readFile = FileHandle.init(forReadingAtPath: filePath),
            let writeFile = FileHandle.init(forWritingAtPath: outFilePath) {
            
            readFile.decrypt(self, outFile: writeFile)
            
            readFile.closeFile()
            writeFile.closeFile()
        }
    }
}

// MARK: - Data TEA

fileprivate extension Data {
    
    /**
     TEA加密
     - parameter    tea:    TEA密钥
     */
    mutating func encrypt(_ tea: TEA) {
        
        let delta: UInt32 = 0x9e3779b9
        
        /// 补位
        if self.count%8 != 0 {
            
            for _ in 0..<(8 - self.count%8) {
                
                self.append(contentsOf: [0])
            }
        }
        
        for i in 0..<self.count/8 {
            
            let a = UInt32(self[i * 8 + 0]) << 24
            let b = UInt32(self[i * 8 + 1]) << 16
            let c = UInt32(self[i * 8 + 2]) << 8
            let d = UInt32(self[i * 8 + 3]) << 0
            
            let e = UInt32(self[i * 8 + 4]) << 24
            let f = UInt32(self[i * 8 + 5]) << 16
            let g = UInt32(self[i * 8 + 6]) << 8
            let h = UInt32(self[i * 8 + 7]) << 0
            
            var x = a + b + c + d
            var y = e + f + g + h
            
            var sum: UInt32 = 0
            
            for _ in 0..<(1<<tea.number) {
                
                sum = sum &+ delta
                
                x = x &+ (((y<<4) &+ tea.key.0) ^ (y &+ sum) ^ ((y>>5) &+ tea.key.1))
                y = y &+ (((x<<4) &+ tea.key.2) ^ (x &+ sum) ^ ((x>>5) &+ tea.key.3))
            }
            
            self[i * 8 + 0] = UInt8((x << 0 ) >> 24)
            self[i * 8 + 1] = UInt8((x << 8 ) >> 24)
            self[i * 8 + 2] = UInt8((x << 16) >> 24)
            self[i * 8 + 3] = UInt8((x << 24) >> 24)
            self[i * 8 + 4] = UInt8((y << 0 ) >> 24)
            self[i * 8 + 5] = UInt8((y << 8 ) >> 24)
            self[i * 8 + 6] = UInt8((y << 16) >> 24)
            self[i * 8 + 7] = UInt8((y << 24) >> 24)
        }
    }
    
    /**
     TEA解密
     - parameter    tea:    TEA密钥
     */
    mutating func decrypt(_ tea: TEA) {
        
        let delta: UInt32 = 0x9e3779b9
        
        for i in 0..<self.count/8 {
            
            let a = UInt32(self[i * 8 + 0]) << 24
            let b = UInt32(self[i * 8 + 1]) << 16
            let c = UInt32(self[i * 8 + 2]) << 8
            let d = UInt32(self[i * 8 + 3]) << 0
            
            let e = UInt32(self[i * 8 + 4]) << 24
            let f = UInt32(self[i * 8 + 5]) << 16
            let g = UInt32(self[i * 8 + 6]) << 8
            let h = UInt32(self[i * 8 + 7]) << 0
            
            var x = a + b + c + d
            var y = e + f + g + h
            
            var sum: UInt32 = delta << tea.number
            
            for _ in 0..<(1<<tea.number) {
                
                y = y &- (((x<<4) &+ tea.key.2) ^ (x &+ sum) ^ ((x>>5) &+ tea.key.3))
                x = x &- (((y<<4) &+ tea.key.0) ^ (y &+ sum) ^ ((y>>5) &+ tea.key.1))
                
                sum = sum &- delta
            }
            
            self[i * 8 + 0] = UInt8((x << 0 ) >> 24)
            self[i * 8 + 1] = UInt8((x << 8 ) >> 24)
            self[i * 8 + 2] = UInt8((x << 16) >> 24)
            self[i * 8 + 3] = UInt8((x << 24) >> 24)
            self[i * 8 + 4] = UInt8((y << 0 ) >> 24)
            self[i * 8 + 5] = UInt8((y << 8 ) >> 24)
            self[i * 8 + 6] = UInt8((y << 16) >> 24)
            self[i * 8 + 7] = UInt8((y << 24) >> 24)
        }
    }
}

// MARK: - FileHandle TEA

fileprivate extension FileHandle {
    
    /**
     TEA加密
     - parameter    tea:        TEA密钥
     - parameter    outFile:    输出加密文件
     - parameter    size:       每段加密大小（默认放大8倍，TEA每次轮询8位进行加密）
     */
    func encrypt(_ tea: TEA, outFile: FileHandle, size: UInt64 = 1024) {
        
        let size8 = 8*size
        let fileSize = self.seekToEndOfFile()
        var readSize: UInt64 = 0
        
        outFile.truncateFile(atOffset: 0)
        
        while readSize < fileSize {
            
            self.seek(toFileOffset: readSize)
            let length = min(size8, fileSize)
            var data = self.readData(ofLength: Int(length))
            data.encrypt(tea)
            outFile.seekToEndOfFile()
            outFile.write(data)
            readSize += length
        }
        outFile.synchronizeFile()
    }
    
    /**
     TEA解密
     - parameter    tea:        TEA密钥
     - parameter    outFile:    输出解密文件
     - parameter    size:       每段解密大小（默认放大8倍，TEA每次轮询8位进行解密）
     */
    func decrypt(_ tea: TEA, outFile: FileHandle, size: UInt64 = 1024) {
        
        let size8 = 8*size
        let fileSize = self.seekToEndOfFile()
        var readSize: UInt64 = 0
        
        outFile.truncateFile(atOffset: 0)
        
        while readSize < fileSize {
            
            self.seek(toFileOffset: readSize)
            let length = min(size8, fileSize)
            var data = self.readData(ofLength: Int(length))
            data.decrypt(tea)
            outFile.seekToEndOfFile()
            outFile.write(data)
            readSize += length
        }
        outFile.synchronizeFile()
    }
}

fileprivate extension FileManager {
    
    /**
     创建文件
     - parameter    filePath:       文件路径
     - parameter    contents:       文件内容
     - parameter    attributes:     文件信息
     */
    func createFile(_ filePath: String, contents: Data? = nil, attributes: [FileAttributeKey: Any]? = nil) -> Bool {
        
        if FileManager.default.fileExists(atPath: filePath) {
            
            return true
        }
        
        var pathArray = filePath.components(separatedBy: "/")
        
        if pathArray.count > 2 {
            
            pathArray.removeLast()
            let directoryPath = pathArray.joined(separator: "/")
            
            if !FileManager.default.fileExists(atPath: directoryPath)  {
                
                do {
                    try createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    
                }
            }
        }
        return createFile(atPath: filePath, contents: contents, attributes: attributes)
    }
}
