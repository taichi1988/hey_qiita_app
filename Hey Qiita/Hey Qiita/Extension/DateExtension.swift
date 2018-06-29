//
//  DateExtension.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/24.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import Foundation

extension Date {
    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        calendar.locale = Locale(identifier: "ja_JP")
        return calendar
    }
    
    // MARK: - Components
    var year: Int { return calendar.component(.year, from: self) }
    
    var month: Int { return calendar.component(.month, from: self) }
    
    var day: Int { return calendar.component(.day, from: self) }
    
    var hour: Int { return calendar.component(.hour, from: self) }
    
    var minute: Int { return calendar.component(.minute, from: self) }
    
    var second: Int { return calendar.component(.second, from: self) }
    
    // MARK: - Custom format
    var yyyyMMdd: String {
        return "\(year)/\(month)/\(day)"
    }
}
