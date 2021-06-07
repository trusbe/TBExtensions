//
//  Logger.swift
//  TBExtensions
//
//  Created by mac on 2019/5/29.
//  Copyright © 2019 TrusBe. All rights reserved.
//

import Foundation
import CoreBluetooth

// Logger
public func logger(_ title: String, sub: String, info: String?) {
    if info == nil {
        print("\(Date()) [\(title)], \(sub)")
    } else {
        print("\(Date()) [\(title)], \(sub), \(info!)")
    }
}

public func logError(_ title: String, sub: String, error: Error?) {
    if let e = error as? CBError {
        print("\(Date()) [\(title)], \(sub), Error: \(e.code), \(e.localizedDescription)")
    } else {
        print("\(Date()) [\(title)], \(sub), Error: \(error!.localizedDescription)")
    }
}
