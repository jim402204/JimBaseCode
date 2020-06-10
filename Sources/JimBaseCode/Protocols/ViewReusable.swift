//
//  ViewReusable.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public protocol ViewReusable: class {}

public extension ViewReusable where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ViewReusable {}
extension UITableViewHeaderFooterView: ViewReusable {}
extension UICollectionReusableView: ViewReusable {}
