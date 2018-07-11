//
//  ViewController.swift
//  TBExtensions
//
//  Created by TrusBe on 2018/7/10.
//  Copyright © 2018年 TrusBe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Data
        let str = "Hello World!"
        let data = str.tb_utf8Data!
        print("Data, hexString: \(data.tb_hexString)\n")
        print("Data, Bytes: \(data.tb_bytes)\n")
        let randData = Data.tb_dataWithNumberOfBytes(5)
        print("Data, dataWithNumberOfBytes: \(randData.tb_hexString)\n")


        // String
        let tData = Data([0xdf])
        let tStr = tData.tb_hexString
        let tBinary = "11011111"
        print("String, hexToDecimal: \(tStr.tb_hexToDecimal)\n")
        print("String, hexToBinary: \(tStr.tb_hexToBinary)\n")
        print("String, binaryToDecimal: \(tBinary.tb_binaryToDecimal)\n")
        print("String, binaryToHex: \(tBinary.tb_binaryToHex)\n")

        let hexStr = data.tb_hexString
        let bytes: [UInt8] = hexStr.tb_bytes
        print("String, bytes: \(bytes)\n")

        // Int
        let aInt = 223
        print("Int, toBinary: \(aInt.tb_toBinary)\n")
        print("Int, toHex: \(aInt.tb_toHex)\n")

        
        
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

