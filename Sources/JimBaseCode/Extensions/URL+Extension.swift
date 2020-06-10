//
//  URL+Extension.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import Foundation

public extension URL {
    /// test=1&a=b&c=d => ["test":"1","a":"b","c":"d"]
    /// 解析網址query轉換成[String: String]數組資料
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        
        return parameters
    }
    
}
