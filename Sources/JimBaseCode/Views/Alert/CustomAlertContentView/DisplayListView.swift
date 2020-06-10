//
//  DisplayListView.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/5/26.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

class DisplayListView: UIView {
    
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var inView: UIView!
    @IBOutlet weak var showLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.useShadow(shadowOffset: CGSize(width: 1, height: 2), shadowRadius: 4, shadowOpacity: 0.15)
        shadowView.backgroundColor = .clear
        
        inView.layer.cornerRadius = 5
        inView.clipsToBounds = true
    }
    
}

extension DisplayListView: NibInitializable {}
