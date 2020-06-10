//
//  DisplayLabelEx3View.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/5/26.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

class DisplayAppealView: UIView {
    
    @IBOutlet weak var order: UILabel!
    @IBOutlet weak var subAccount: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var channelAndAmount: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setLabel(subAccount: String? = nil, order: String, time: String, channelAndAmount: String, name: String, nickName: String,status: String) {
        
        if let subAccount = subAccount {
            self.subAccount.text = subAccount
        }
        self.order.text = order
        self.time.text = time
        self.channelAndAmount.text = channelAndAmount
        self.name.text = name
        self.nickName.text = nickName
        self.status.text = status
    }
    
}

extension DisplayAppealView: NibInitializable {}
