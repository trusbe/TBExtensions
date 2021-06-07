//
//  TBRegExp.swift
//  TBExtensions
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 TrusBe. All rights reserved.
//

import Foundation

// MARK: - TBRegExp
public class TBRegExp {
    public static func regExp(_ str:String,_ pattern:String)->Bool{
        let regex = try! NSRegularExpression(pattern: pattern, options:[NSRegularExpression.Options.caseInsensitive])
        let resultNum = regex.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0) , range: NSMakeRange(0, str.count))
        if resultNum >= 1 {
            return true
        }
        return false
    }

    public static func uuid(_ aValue: String) -> Bool {
        return self.regExp(aValue, "(\\w{8}(-\\w{4}){3}-\\w{12}?)")
    }
    
    public static func mac(_ aValue: String) -> Bool {
        return self.regExp(aValue, "^[A-F0-9]{2}(:[A-F0-9]{2}){5}$")
    }
    
    // 至少包含 数字和英文，长度6-20："^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$"
    // 包含 数字,英文,字符中的两种以上，长度6-20："^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?!([^(0-9a-zA-Z)])+$).{6,20}$"
    // 至少包含数字跟字母，可以有字符："(?=.*([a-zA-Z].*))(?=.*[0-9].*)[a-zA-Z0-9-*/+.~!@#$%^&*()]{6,20}$"
    public static func password(_ aValue: String) -> Bool {
        return self.regExp(aValue, "(?=.*([a-zA-Z].*))(?=.*[0-9].*)[a-zA-Z0-9-*/+.~!@#$%^&*()]{6,20}$")
    }
    
    public static func phoneNumber(_ aValue: String) -> Bool {
        return self.regExp(aValue, "^[0-9]{11}$")
    }
    
    public static func captcha(_ aValue: String) -> Bool {
        return self.regExp(aValue, "^[0-9]{6}$")
    }
    
    public static func email(_ aValue: String) -> Bool {
        return self.regExp(aValue, "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    }
    
    public static func isPhoneNumber(_ aValue: String) -> Bool {
        return self.regExp(aValue, "^((13[0-9])|(15[^4,\\D]) |(17[0,0-9])|(18[0,0-9]))\\d{8}$")
    }
    
    public static func isCarNumber(_ aValue: String) -> Bool {
        return self.regExp(aValue, "^[A-Za-z]{1}[A-Za-z_0-9]{5}$")
    }
    
    public static func isUserName(_ aValue: String) -> Bool {
        return self.regExp(aValue, "^[A-Za-z0-9]{6,20}+$")
    }
    
    public static func isNickName(_ aValue: String) -> Bool {
        return self.regExp(aValue, "^[\\u4e00-\\u9fa5]{4,8}$")
    }
    
    public static func isURL(_ aValue: String) -> Bool {
        return self.regExp(aValue, "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$")
    }
    
    public static func isIP(_ aValue: String) -> Bool {
        return self.regExp(aValue, "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
    }
    
    public static func isPort(_ aValue: String) -> Bool {
        return self.regExp(aValue, "^[0-9]{1,5}$")
    }
}
