//
//  TBUUID.swift
//  TBExtensions
//
//  Created by mac on 2021/6/7.
//  Copyright © 2021 TrusBe. All rights reserved.
//

import Foundation

public extension UUID {
    /// Creates the UUID from a 32-character hexadecimal string.
    init?(hex: String) {
        guard hex.count == 32 else {
            return nil
        }
        var uuidString = ""
        for (offset, character) in hex.enumerated() {
            if offset == 8 || offset == 12 || offset == 16 || offset == 20 {
                uuidString.append("-")
            }
            uuidString.append(character)
        }
        guard let uuid = UUID(uuidString: uuidString) else {
            return nil
        }
        self.init(uuid: uuid.uuid)
    }
    
    /// Returns the uuidString without dashes.
    var hex: String {
        return uuidString.replacingOccurrences(of: "-", with: "")
    }
    
    /// The UUID as Data.
    var data: Data {
        return withUnsafeBytes(of: uuid, { Data($0) })
    }
}
