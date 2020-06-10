//
//  DisplayLabelEx2View.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/5/26.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

class DisplayReciveOrderView: UIView {
    
    @IBOutlet weak var order: UILabel!
    @IBOutlet weak var subAccount: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var orderAmount: UILabel!
    @IBOutlet weak var channelAndRealAmount: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var rewardAmount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setLabel(subAccount: String? = nil, order: String, time: String, orderAmount: String, channelAndRealAmount: String, name: String, nickName: String, status: String, rewardAmount: Double) {
        
        if let subAccount = subAccount {
            self.subAccount.text = subAccount
        }
        
        self.order.text = order
        self.time.text = time
        self.orderAmount.text = orderAmount
        self.channelAndRealAmount.text = channelAndRealAmount
        self.name.text = name
        self.nickName.text = nickName
        self.status.text = status
        self.rewardAmount.text = rewardAmount.doubleOrInt()
    }
    
}

extension DisplayReciveOrderView: NibInitializable {}
