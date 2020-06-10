//
//  ViewModelUseFunc.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/5/6.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public protocol ViewModelUseFunc {}

public extension ViewModelUseFunc where Self: UIViewController {
    
    func popAlert(message: String) {
//        self.showAlert(message: message, type: .info)
        
        self.showChannelAlert(messageLabel: message)
    }
}
