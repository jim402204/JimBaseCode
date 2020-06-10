//
//  ShadowView.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/4/6.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        useShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func useShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    func useShadow(shadowOffset: CGSize, shadowRadius: CGFloat,shadowOpacity: Float) {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.masksToBounds = false
    }
    
    
    /// 之後用來切兩層的方法      父層加陰影 子層 切圓角並用clipsToBounds 把父層的一併切掉 背景要clear才看得到陰影
    func clipCornerRadius(childView: UIView? = nil, cornerRadius: CGFloat) {
        
        useShadow()
        backgroundColor = .clear
        
        if let childView = childView{
            
            childView.layer.cornerRadius = cornerRadius
            childView.clipsToBounds = true
        } else {
            
            if let subview = self.subviews.first {
                subview.layer.cornerRadius = cornerRadius
                subview.clipsToBounds = true
            }
        }
    }
    
}

