//
//  TBRegExp.swift
//  TBExtensions
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 TrusBe. All rights reserved.
//

import Foundation

// MARK: - TBRegExp
class TBRegExp {
    static func test(_ str:String,_ pattern:String)->Bool{
        let regex = try! NSRegularExpression(pattern: pattern, options:[NSRegularExpression.Options.caseInsensitive])
        let resultNum = regex.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0) , range: NSMakeRange(0, str.count))
        if resultNum >= 1 {
            return true
        }
        return false
//        return str.range(of: pattern, options:.regularExpression) != nil//or do something like this: return RegExpParser.match(pattern,options).count > 0
    }
    
    public static func isValidUUID(_ aValue: String) -> Bool {
        return self.test(aValue, "(\\w{8}(-\\w{4}){3}-\\w{12}?)")
    }
    
    public static func isValidMacAddr(_ aValue: String) -> Bool {
        return self.test(aValue, "^[A-F0-9]{2}(:[A-F0-9]{2}){5}$")
    }
    
    public static func isValidPassword(_ aValue: String) -> Bool {
        return self.test(aValue, "^[A-Za-z0-9]{6,20}$")
    }
    
    public static func isValidPhoneNumber(_ aValue: String) -> Bool {
        return self.test(aValue, "^[0-9]{11}$")
    }
    
    public static func isValidEmail(_ aValue: String) -> Bool {
        return self.test(aValue, "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    }
    
    public static func isPhoneNumber(_ aValue: String) -> Bool {
        return self.test(aValue, "^((13[0-9])|(15[^4,\\D]) |(17[0,0-9])|(18[0,0-9]))\\d{8}$")
    }
    
    public static func isCarNumber(_ aValue: String) -> Bool {
        return self.test(aValue, "^[A-Za-z]{1}[A-Za-z_0-9]{5}$")
    }
    
    public static func isUserName(_ aValue: String) -> Bool {
        return self.test(aValue, "^[A-Za-z0-9]{6,20}+$")
    }
    
    public static func isNickName(_ aValue: String) -> Bool {
        return self.test(aValue, "^[\\u4e00-\\u9fa5]{4,8}$")
    }
    
    public static func isURL(_ aValue: String) -> Bool {
        return self.test(aValue, "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$")
    }
    
    public static func isIP(_ aValue: String) -> Bool {
        return self.test(aValue, "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
    }
}
