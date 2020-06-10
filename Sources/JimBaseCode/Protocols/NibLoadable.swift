//
//  NibLoadable.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import Foundation

import UIKit

public protocol NibLoadable {}

public extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
