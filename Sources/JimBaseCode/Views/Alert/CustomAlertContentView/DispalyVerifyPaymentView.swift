//
//  DispalyVerifyPaymentView.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/6/5.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

class DispalyVerifyPaymentView: UIView {
    
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var channelAndAmount: UILabel!
    @IBOutlet weak var amount: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLabel(orderNumber: String, channelAndAmount: String, amount: String) {
        
        self.orderNumber.text = orderNumber
        self.channelAndAmount.text = channelAndAmount
        self.amount.text = amount
    }
    
}

extension DispalyVerifyPaymentView: NibInitializable {}
