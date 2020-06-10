//
//  DispalyLabelView.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/5/25.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public class DispalyLabelView: UIView {
    
    @IBOutlet weak var account: UILabel!
    @IBOutlet weak var bank: UILabel!
    @IBOutlet weak var cardMumber: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func setLabel(account: String, bank: String, cardMumber: String) {
        
        self.account.text = account
        self.bank.text = bank
        self.cardMumber.text = cardMumber
    }
    
}

extension DispalyLabelView: NibInitializable {}
