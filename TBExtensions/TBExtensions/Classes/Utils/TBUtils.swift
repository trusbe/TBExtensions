//
//  TBUtils.swift
//  TBExtensions
//
//  Created by TrusBe on 2018/7/10.
//  Copyright © 2018年 TrusBe. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth


// MARK: Size

/// 屏幕尺寸
public let ScreenSize                           = UIScreen.main.bounds.size
/// 屏幕宽度
public let ScreenWidth                          = ScreenSize.width
/// 屏幕高度
public let ScreenHeight                         = ScreenSize.height

/// 视图的宽度
/// - Parameter view: 视图
/// - Returns: 宽度
public func Width(_ view: UIView) ->CGFloat {
    return view.frame.size.width
}

/// 视图的高度
/// - Parameter view: 视图
/// - Returns: 高度
public func Height(_ view: UIView) ->CGFloat {
    return view.frame.size.height
}

/// 视图起点 X 坐标
/// - Parameter view: 视图
/// - Returns: X 坐标
public func XStart(_ view: UIView) ->CGFloat {
    return view.frame.origin.x
}

/// 视图起点的 Y 坐标
/// - Parameter view: 视图
/// - Returns: Y 坐标
public func YStart(_ view: UIView) ->CGFloat {
    return view.frame.origin.y
}

/// 视图终点的 X 坐标
/// - Parameter view: 视图
/// - Returns: X 坐标
public func XEnd(_ view: UIView) ->CGFloat {
    return view.frame.origin.x + view.frame.size.width
}

/// 视图终点的 Y 坐标
/// - Parameter view: 视图
/// - Returns: Y 坐标
public func YEnd(_ view: UIView) ->CGFloat {
    return view.frame.origin.y + view.frame.size.height
}

/// 视图的中心坐标
/// - Parameter view: 视图
/// - Returns: 坐标
public func Center(_ view: UIView) ->CGPoint {
    return view.center
}

/// 视图中心 X 坐标
/// - Parameter view: 视图
/// - Returns: X 坐标
public func XCenter(_ view: UIView) ->CGFloat {
    return view.center.x
}

/// 视图中心 Y 坐标
/// - Parameter view: 视图
/// - Returns: Y 坐标
public func YCenter(_ view: UIView) ->CGFloat {
    return view.center.y
}

// MARK: Device Type
public let iPad: Bool                           = (UIDevice.current.userInterfaceIdiom == .pad)
public let iPhone: Bool                         = (UIDevice.current.userInterfaceIdiom == .phone)
public let carPlay: Bool                        = (UIDevice.current.userInterfaceIdiom == .carPlay)
public let tv: Bool                             = (UIDevice.current.userInterfaceIdiom == .tv)

@available(iOS 14.0, *)
public let mac: Bool                            = (UIDevice.current.userInterfaceIdiom == .mac)

public let iPhone4: Bool                        = (ScreenHeight == 480.0 ? true : false)
public let iPhone5: Bool                        = (ScreenHeight == 568.0 ? true : false)
public let iPhone6: Bool                        = (ScreenHeight == 667.0 ? true : false)
public let iPhone6Plus: Bool                    = (ScreenHeight == 736.0 ? true : false)
public let iPhoneX: Bool                        = (ScreenHeight == 812.0 ? true : false)
public let iPhoneXR: Bool                       = (ScreenHeight == 896.0 ? true : false)
public let iPhone12Mini: Bool                   = (ScreenHeight == 780.0 ? true : false)
public let iPhone12: Bool                       = (ScreenHeight == 844.0 ? true : false)
public let iPhone12Max: Bool                    = (ScreenHeight == 926.0 ? true : false)
public let fullScreen: Bool                     = (ScreenHeight >= 812.0 ? true : false)

// MARK: Public Height
public let kStatusBarHeight: CGFloat            = (fullScreen ? 44.0 : 20.0)
public let kNavBarHeight: CGFloat               = 44.0

public let kOtherNavHeight: CGFloat             = 64.0
public let kXNavHeight: CGFloat                 = 88.0

public let kOtherTabHeight: CGFloat             = 49.0
public let kXTabHeight: CGFloat                 = 83.0
public let kTabSafeHeight: CGFloat              = (fullScreen ? kXFootHeight : 0)

public let kOtherAllHeight: CGFloat             = kOtherNavHeight + kOtherTabHeight
public let kXAllHeight: CGFloat                 = kXNavHeight + kXTabHeight

public let kXFootHeight: CGFloat                = 34.0

public let kNavStatusBarHeight: CGFloat         = (fullScreen ? kXNavHeight : kOtherNavHeight)
public let kLargeNavStatusBarHeight: CGFloat          = 140
public let kNavHeight: CGFloat                  = (fullScreen ? (kXNavHeight-kStatusBarHeight) : (kOtherNavHeight-kStatusBarHeight))
public let kTabHeight: CGFloat                  = (fullScreen ? kXTabHeight : kOtherTabHeight)
public let kContentHeight: CGFloat              = (fullScreen ? ScreenHeight-kXAllHeight : ScreenHeight-kOtherNavHeight)
public let kContentTabHeight: CGFloat           = (fullScreen ? ScreenHeight-(kXAllHeight+kOtherTabHeight) : ScreenHeight-kOtherAllHeight)


public func kNavBarHeight(viewController: UIViewController) -> CGFloat {
    return viewController.navigationController?.navigationBar.frame.height ?? 0.0
}

// 角度弧度互转
public func DEGREE_TO_RADIAN(degree: Double) -> Double {
    return ((degree) * Double.pi) / 180.0
}

public func RADIAN_TO_DEGREE(radian: Double) -> Double {
    return ((radian) * 180) / Double.pi
}


public class TBUtils {
    /// 拆分数据
    /// - Parameters:
    ///   - someData: 总数据内容
    ///   - aChunkSize: 每包数据长度
    /// - Returns: 返回拆分区间数组
    static func calculateDataRanges(_ someData: Data, withSize aChunkSize: Int) -> [Range<Int>] {
        var totalLength = someData.count
        var ranges = [Range<Int>]()
        var partIdx = 0
        while (totalLength > 0) {
            var range : Range<Int>
            if totalLength > aChunkSize {
                totalLength -= aChunkSize
                range = (partIdx * aChunkSize) ..< aChunkSize + (partIdx * aChunkSize)
            } else {
                range = (partIdx * aChunkSize) ..< totalLength + (partIdx * aChunkSize)
                totalLength = 0
            }
            ranges.append(range)
            partIdx += 1
        }
        return ranges
    }
}
