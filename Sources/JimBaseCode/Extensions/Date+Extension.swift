//
//  Date+Extension.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import Foundation

public extension Int64 {

    func milisecondsStampToDate() -> Date {
        let timeInterval: TimeInterval = TimeInterval(self / 1000)
        return Date(timeIntervalSince1970: timeInterval)
    }

}

public extension Int {

    func milisecondsStampToDate() -> Date {
        let timeInterval: TimeInterval = TimeInterval(self / 1000)
        return Date(timeIntervalSince1970: timeInterval)
    }

}

public extension Double {
    
    /// 判斷是Double 還是 Int 轉為String
    func doubleOrInt() -> String {
        
        let decimal = Int(self)
        
        if self == Double(decimal) {
            return String(decimal)
        } else {
            return String(self)
        }
    }
}

public extension Date {

    init?(string: String) {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: string) else { return nil }
        self = date
    }
    
    /// 轉成標準日期字串
    var defaultString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    var versionString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMddHHmmss"
        return dateFormatter.string(from: self)
    }
    
    var iso8601String: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.string(from: self)
    }

    func toStampString() -> String {
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let stampString = String(timeStamp)
        return stampString
    }

    func toMilisecondsStampString() -> String {
        let timeInterval:TimeInterval = Date().timeIntervalSince1970 * 1000
        let timeStamp = Int(timeInterval)
        let stampString = String(timeStamp)
        return stampString
    }

    func toMilisecondsStampString(with latencyTime: Int) -> String {
        let timeInterval:TimeInterval = Date().timeIntervalSince1970 * 1000
        let timeStamp = Int(timeInterval) + latencyTime
        let stampString = String(timeStamp)
        return stampString
    }
    
}
