//
//  DispalyLabelViewEx1View.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/5/25.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

class DisplayAccountChangeView: UIView {
    
    @IBOutlet weak var subItem: UIStackView!
    @IBOutlet weak var subAccount: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var blance: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func setLabel(subAccount: String? = nil, type: String, time: String, amount: String, blance: String, desc: String) {
        
        if let subAccount = subAccount {
            self.subAccount.text = subAccount
        } else {
            self.subItem.isHidden = true
        }
        
        self.type.text = type
        self.time.text = time
        self.amount.text = amount
        self.blance.text = blance
        self.desc.text = desc
    }
    
}

extension DisplayAccountChangeView: NibInitializable {}
