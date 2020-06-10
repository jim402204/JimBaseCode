//
//  DispalyVerifyAppealView.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/6/5.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

protocol DispalyVerifyAppealViewProtocol: AnyObject {
    func clickCancelOrder(view: DispalyVerifyAppealView, selected: Bool)
}

class DispalyVerifyAppealView: UIView {
    
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var channelAndAmount: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    @IBOutlet weak var checkButton: UIButton!
    
    weak var delegate: DispalyVerifyAppealViewProtocol? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setLabel(orderNumber: String, channelAndAmount: String) {
        
        self.orderNumber.text = orderNumber
        self.channelAndAmount.text = channelAndAmount
    }
    
    @IBAction func clickAction(_ sender: UIButton) {

        sender.isSelected.toggle()
        checkImageView.image = sender.isSelected ? UIImage(named: "checked-100") : UIImage(named: "unchecked-100")
    }
    
}

extension DispalyVerifyAppealView: NibInitializable {}
