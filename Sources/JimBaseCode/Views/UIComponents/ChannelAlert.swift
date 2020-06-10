//
//  channelAlert.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/4/13.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

class ChannelAlert: UIView {
    
    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    
    var channelName = "支付寶"

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageLabel.text = channelName
    }
    
}

extension ChannelAlert: NibInitializable {}
