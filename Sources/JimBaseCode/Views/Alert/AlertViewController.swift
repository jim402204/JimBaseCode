//
//  AlertViewController.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/4/22.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public class AlertViewController: UIViewController {
    
    public enum AlertType {
        case error
        case info
        
        var imageHightLight: Bool {
            switch self {
            case .error:
                return true
            case .info:
                return false
            }
        }
    }
    
    struct AlertInfo {
        var title: String?
        var message: String
        var imageHightLight: Bool
    }
    
    fileprivate var alertInfo: AlertInfo? {
        didSet {
            titleLabel.text = alertInfo?.title ?? "信息"
            messageLabel.text = alertInfo?.message
            statusImageView.isHighlighted = alertInfo?.imageHightLight ?? false
        }
    }
    
    var setAlertInfo: AlertInfo?
    var clickCompletion: (() -> Void)? = nil
    
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var dismissView: UIView!
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: clickCompletion)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setView()
        alertInfo = setAlertInfo
    }
    
}

public extension AlertViewController {
    
    func setView() {
        
        shadowView.useShadow()
        dismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissAction)))
    }
    
    func setLabel(title: String? = nil, message: String, type: AlertType = .info) {
        setAlertInfo = AlertInfo(title: title, message: message, imageHightLight: type.imageHightLight)
    }
    
}
