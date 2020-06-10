//
//  ShadowConfigurable.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public protocol ShadowConfigurable {}

public extension ShadowConfigurable where Self: UIView {
    func configureShadow(with color: UIColor = .white ,
                         offset: CGSize = CGSize(width: 0, height: 1),
                         radius: CGFloat = 3,
                         opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func configureShadow(with color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
}
