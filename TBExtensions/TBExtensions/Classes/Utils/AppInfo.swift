//
//  AppInfo.swift
//  TBExtensions
//
//  Created by mac on 2019/5/29.
//  Copyright © 2019 TrusBe. All rights reserved.
//

import Foundation
import SystemConfiguration.CaptiveNetwork

public struct AppInfo {
    
    // Non-instantiable.
    private init() {}
    
    /// Returns Application version as String.
    public static var version: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    }
    
    /// Returns Build Number as String.
    public static var buildNumber: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
    }
    
    /// 获取当前连接 WIFI 的 SSID, iOS12 以后需要在项目的 Capabilities -> Access WiFi Information -> ON
    public static func getCurrentWiFiSSID() -> String? {
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid
    }
    /// 获取当前 Wi-Fi SSID, iOS12 以后需要在项目的 Capabilities -> Access WiFi Information -> ON
    public static func getWiFiSSID() -> String? {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else { return nil }
        let key = kCNNetworkInfoKeySSID as String
        for interface in interfaces {
            print("【UIDevice】, WiFiSSID, interface: \(interface)")
            guard let interfaceInfo = CNCopyCurrentNetworkInfo(interface as CFString) as NSDictionary? else { continue }
            print("【UIDevice】, WiFiSSID, interfaceInfo: \(interfaceInfo)")
            return interfaceInfo[key] as? String
        }
        return nil
    }
}
