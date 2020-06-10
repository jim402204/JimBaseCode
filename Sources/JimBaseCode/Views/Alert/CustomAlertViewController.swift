//
//  CustomAlertViewController.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/4/22.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public class CustomAlertViewController: UIViewController {
    
    public enum ActionType {
        case all
        case onlyCanecl
        case onlyConfirm
    }
    
    var actionType: ActionType = .all
    
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var wholeView: UIView!
    
    @IBOutlet weak var dismissView: UIView!
    @IBOutlet weak var alertTitleLabel: UILabel!
    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    var contentView: UIView? = nil
    var contentViews = [UIView]()
    var alertTitleText: String? = nil
    var confirmText: String? = nil
    
    
    var cancelAction: (()->())? = nil
    var confirmAction: (()->())? = nil
    ///預設確認後自動dismiss alert （有時候需要擋掉 不自動關閉 設為fasle 來控制）
    var isSetDismiss = true
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        self.view.addGestureRecognizer(tap)
        
        //防止點到裡面會有作用
        shadowView.addGestureRecognizer(UITapGestureRecognizer(target: nil, action: nil))
    }
    
    
    func set(actionType: ActionType, alertTitleText: String? = nil, content: UIView, confirmText: String? = nil,  confirmAction: @escaping (()->())) {
        
        if let confirmText = confirmText {
            self.confirmText = confirmText
        }
        
        self.alertTitleText = alertTitleText
        self.contentView = content
        self.actionType = actionType
        self.confirmAction = confirmAction
    }
    
}

public extension CustomAlertViewController {
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func comfirmAction(_ sender: UIButton) {
        
        confirmAction?()
        
        if isSetDismiss {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

fileprivate extension CustomAlertViewController {
    
    func setView() {
        
        switch actionType {
        case .all:
            break
            
        case .onlyCanecl:
            confirmButton.isHidden = true
            cancelButton.setTitle("关闭", for: .normal)
        case .onlyConfirm:
            cancelButton.isHidden = true
            confirmButton.setTitle("確認", for: .normal)
        }
        
        if let content = contentView {
            self.contentStackView.addArrangedSubview(content)
        }
        
        if contentViews.count > 0 {
            
            self.contentStackView.distribution = .fillEqually
            
            for item in contentViews {
                self.contentStackView.addArrangedSubview(item)
            }
        }
        
        if let confirmText = confirmText {
            confirmButton.setTitle(confirmText, for: .normal)
        }
        
        if let alertTitleText = alertTitleText {
            self.alertTitleLabel.text = alertTitleText
        }
        
        shadowView.useShadow()
        setShadowCornerRadius()
        dismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissAction)))
    }
    
    func setShadowCornerRadius() {
        wholeView.layer.cornerRadius = 10
        wholeView.layer.masksToBounds = true
        shadowView.backgroundColor = .clear
    }
    
}
