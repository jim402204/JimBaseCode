//
//  paymentCodeAlertVC.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/5/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

protocol InvitationCodeAlertVCProtocol: AnyObject {
    
    func lookQRCode(vc: InvitationCodeAlertVC)
    func copyLink(vc: InvitationCodeAlertVC)
    func lookPoint(vc: InvitationCodeAlertVC)
    func deleteCode(vc: InvitationCodeAlertVC)
}

class InvitationCodeAlertVC: UIViewController {
    
    weak var delegate: InvitationCodeAlertVCProtocol? = nil
//    let httpsManager = HttpsManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: Action

extension InvitationCodeAlertVC {
    
    @IBAction func lookQRCodeAction() {
        delegate?.lookQRCode(vc: self)
    }
    
    @IBAction func copyLinkAction() {
        delegate?.copyLink(vc: self)
    }
    
    @IBAction func lookPointAction() {
        delegate?.lookPoint(vc: self)
    }
    @IBAction func deleteCodeAction() {
        delegate?.deleteCode(vc: self)
    }
    @IBAction func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
