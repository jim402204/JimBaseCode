//
//  DisplayQRcodeView.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/5/26.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

class DisplayQRcodeView: UIView {
    
    @IBOutlet weak var qrcodeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func setLabel(qrcodeImage: UIImage) {
        
        self.qrcodeImageView.image = qrcodeImage
    }
    
}

extension DisplayQRcodeView: NibInitializable {}
