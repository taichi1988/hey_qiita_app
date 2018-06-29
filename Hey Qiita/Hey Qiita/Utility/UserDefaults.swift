//
//  UserDefaults.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/12.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import Foundation

/// UserDefaults Utility
final class UserDefaults {
    private enum Key: String {
        case userId = "user_defaults_user_id"
    }
    
    private static var standard: Foundation.UserDefaults {
        return Foundation.UserDefaults.standard
    }
    
    static var userId: String? {
        get { return standard.string(forKey: Key.userId.rawValue) }
        set { standard.set(newValue, forKey: Key.userId.rawValue) }
    }
}
