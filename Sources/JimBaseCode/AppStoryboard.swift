//
//  AppStoryboard.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import Foundation

import Foundation

public enum AppStoryboard: String {
    
    case login
    case main
    case reciveOrder
    case verifyOrder
    case myAccount
    case profile
    case features
    case saveTakeMoney
    case agencyCenter
    case alert
    case paymentCode
    
    
    var storyboardName: String {
        return rawValue.capitalizingFirstLetter()
    }
}

public extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
}
