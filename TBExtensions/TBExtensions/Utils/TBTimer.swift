//
//  TBTimer.swift
//  TBExtensions
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 TrusBe. All rights reserved.
//

import Foundation

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
/// - repeatInterval: 循环间隔时间
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
