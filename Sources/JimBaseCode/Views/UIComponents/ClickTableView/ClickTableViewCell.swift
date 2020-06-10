//
//  ClickTableViewCell.swift
//  dsb
//
//  Created by Jim on 2020/4/1.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

class ClickTableViewCell: UITableViewCell {

//    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    
    static var setFontSize: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setImageColor()
        wordReSize()
    }
    
}

extension ClickTableViewCell {
    
    func setImageColor() {
        
//          "checked-100"
//        checkImageView.image = UIImage(named: "checked-100" )?.withRenderingMode(.alwaysTemplate)
//        checkImageView.tintColor = .white
//        
//        checkImageView.isHidden = true
    }
    
    func wordReSize() {
        
        guard ClickTableViewCell.setFontSize != 0 else { return }
        itemLabel.font = UIFont.systemFont(ofSize: ClickTableViewCell.setFontSize)
    }
    
}

extension ClickTableViewCell: NibLoadable {}
