//
//  String+Extensions.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import Foundation

import UIKit

public extension String {
    
    var isMobileCarrier: Bool {
        do {
            return try isFullMatch("^/[0-9A-Z+-.]{7}$")
        } catch {
            return false
        }
    }
    
    var isEmail: Bool {
        do {
            return try isFullMatch("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
        } catch {
            return false
        }
    }
    
    private func isFullMatch(_ regularExpression: String) throws -> Bool {
        let regex = try NSRegularExpression(pattern: regularExpression, options: [])
        let range = NSRange(0 ..< count)
        let matches = regex.matches(in: self, options: [], range: range)
        var isMatch = false
        for _ in matches {
            isMatch = true
        }
        return isMatch
    }
    
}

public extension String {
    
    /// 依據自行返回文字總寬度
    ///
    /// - Parameter font: 計算的字型
    /// - Returns: 返回依據文字計算的寬度
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
   
}


public extension String {

    func milisecondsStampToDate() -> Date {
        let timeStamp = Int(self) ?? 0
        let timeInterval: TimeInterval = TimeInterval(timeStamp / 1000)
        return Date(timeIntervalSince1970: timeInterval)
    }

    /// SwifterSwift: Create date object from ISO8601 string.
    ///
    ///     let date = Date(iso8601String: "2017-01-12T16:48:00.959Z") // "Jan 12, 2017, 7:48 PM"
    ///
    /// - Parameter iso8601String: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
    func iso8601StringToDate() -> Date? {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.date(from: self)
    }

    /// SwifterSwift: Array of characters of a string.
    var charactersArray: [Character] {
        return Array(self)
    }

}

public extension String {

    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)

        return ceil(boundingBox.height)
    }

    public func width(withConstrainedHeight height: CGFloat, font: UIFont, minimumTextWrapWidth:CGFloat) -> CGFloat {

        var textWidth:CGFloat = minimumTextWrapWidth
        let incrementWidth:CGFloat = minimumTextWrapWidth * 0.1
        var textHeight:CGFloat = self.height(withConstrainedWidth: textWidth, font: font)

        //Increase width by 10% of minimumTextWrapWidth until minimum width found that makes the text fit within the specified height
        while textHeight > height {
            textWidth += incrementWidth
            textHeight = self.height(withConstrainedWidth: textWidth, font: font)
        }
        return ceil(textWidth)
    }

}

public extension NSAttributedString {

    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.width)
    }

}
