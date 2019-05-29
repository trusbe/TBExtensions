//
//  Logger.swift
//  TBExtensions
//
//  Created by mac on 2019/5/29.
//  Copyright © 2019 TrusBe. All rights reserved.
//

import Foundation

// Logger
public func logger(with title: String, subTitle: String, info: String?) {
    if info == nil {
        print("【\(title)】, \(subTitle)")
    } else {
        print("【\(title)】, \(subTitle), \(info!)")
    }
}
