//
//  ViewController.swift
//  TBExtensions
//
//  Created by xuntong on 2018/7/10.
//  Copyright © 2018年 TrusBe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Data
        let str = "Hello World!"
        let data = str.utf8Data!
        print("Data, hexString: \(data.hexString)\n")
        print("Data, Bytes: \(data.bytes)\n")
        let randData = Data.dataWithNumberOfBytes(5)
        print("Data, dataWithNumberOfBytes: \(randData.hexString)\n")


        // String
        let tData = Data([0xdf])
        let tStr = tData.hexString
        let tBinary = "11011111"
        print("String, hexToDecimal: \(tStr.hexToDecimal)\n")
        print("String, hexToBinary: \(tStr.hexToBinary)\n")
        print("String, binaryToDecimal: \(tBinary.binaryToDecimal)\n")
        print("String, binaryToHex: \(tBinary.binaryToHex)\n")

        let hexStr = data.hexString
        let bytes: [UInt8] = hexStr.bytes
        print("String, bytes: \(bytes)\n")

        // Int
        let aInt = 223
        print("Int, toBinary: \(aInt.toBinary)\n")
        print("Int, toHex: \(aInt.toHex)\n")

        
        
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

