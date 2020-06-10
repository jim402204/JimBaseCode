//
//  UIViewController+Extension.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/4/6.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

//使用Self init 自己 對應xib id

public extension UIViewController {    //用在QRCode
    
    static func initXibVC() -> Self {
        let scanVC = self.init(nibName: String(describing: self), bundle: nil)
        return scanVC
    }
    
    func presentXib<T: UIViewController>(type: T.Type ,withNaigation: Bool = true , done: ((T)->())? = nil) {
        
        let vc: T  = T.initXibVC()
        done?(vc)
        
        let navigaVC = UINavigationController(rootViewController: vc)
        navigaVC.modalPresentationStyle = .fullScreen
        
        
        self.present(navigaVC, animated: true, completion: nil)
    }
    
}

public extension UIViewController {
        
    func pushUIStoryboard<T: UIViewController>(type: T.Type ,storyboard: AppStoryboard, done: ((T)->())? = nil) {
        
        let vc: T  = UIStoryboard(storyboard: storyboard).instantiateViewController()
        done?(vc)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentUIStoryboard<T: UIViewController>(type: T.Type ,storyboard: AppStoryboard, done: ((T)->())? = nil) {
        
        let vc: T  = UIStoryboard(storyboard: storyboard).instantiateViewController()
        done?(vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    func addGestureEndEditing() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        //當底層view手勢 吃掉TableView的點擊時 取消手勢TouchesInView
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
        
        for subview in self.view.subviews {
            guard let shadowView = subview as? ShadowView else { continue }
            guard let _ = shadowView.subviews.first as? UITableView else { continue }

            shadowView.animate(.hide)
        }
    }
    
}

public extension UIViewController {
    
    func showAlert(title: String? = nil, message: String, type: AlertViewController.AlertType, clickCompletion: (() -> Void)? = nil) {
        
        presentUIStoryboard(type: AlertViewController.self, storyboard: .alert) { vc in
            vc.setLabel(title: title, message: message, type: type)
            vc.clickCompletion = clickCompletion
        }
    }
    
    func showCustomAlert(type: CustomAlertViewController.ActionType = .all, title: String? = nil, content: UIView, confirmText: String? = nil, confirmAction: @escaping ((CustomAlertViewController)->())) {
        
        let vc: CustomAlertViewController  = UIStoryboard(storyboard: .alert).instantiateViewController()
        
        vc.set(actionType: type, alertTitleText: title, content: content, confirmText: confirmText, confirmAction: {
            
            confirmAction(vc)
        })
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func showCustomAlertContents(type: CustomAlertViewController.ActionType = .all, title: String? = nil, contents: [UIView]) {
        
        let vc: CustomAlertViewController  = UIStoryboard(storyboard: .alert).instantiateViewController()
        
        vc.alertTitleText = title
        vc.actionType = type
        vc.contentViews = contents
        
        self.present(vc, animated: true, completion: nil)
    }
    
}

public extension UIViewController {
    
    func showAlertCellDelegateIsTopVC(title: String? = nil, message: String, type: AlertViewController.AlertType) {
        
        let vc: AlertViewController  = UIStoryboard(storyboard: .alert).instantiateViewController()
        vc.setLabel(title: title, message: message, type: type)
        
        let currentTopVC: UIViewController = self.currentTopViewController()
        currentTopVC.present(vc, animated: true, completion: nil)
        
        //Attempt to present <dsb.AlertViewController: 0x10a307fe0> on <dsb.SettingPaymentCodeViewController: 0x100f1e620> whose view is not in the window hierarchy!
        //cell delegate = topVC (wwindow VC)   在ＶＣ 回來的cellDelegate 沒有拿到VC 就present alert 會顯示上面的錯誤   window還沒準備好（需要去試圖presentedViewController撈）就present
    }
    
    func currentTopViewController() -> UIViewController {
        var topVC: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController
        while ((topVC?.presentedViewController) != nil) {
            topVC = topVC?.presentedViewController
        }
        return topVC!
    }
    
}

public extension UIViewController {
    
    func showChannelAlert(messageLabel: String)  {
        
        let alertView = ChannelAlert.instanciateFromNib()
               
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.messageLabel.text = messageLabel
        
        var y: NSLayoutConstraint!
        let viewHight: CGFloat = 60
        
        if self is UITableViewController {
            //for UITableViewController
            let topAnchor = viewHight * 0.5
            let navigationHight = self.navigationController?.navigationBar.frame.size.height ?? 44
            let statusbarHeight = UIApplication.shared.statusBarFrame.height
            
            y = alertView.topAnchor.constraint(equalTo: view.topAnchor, constant: (screenSize.height / 2) - navigationHight - topAnchor - statusbarHeight)
        } else {
            y = alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        }
        
        let x = alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let h = alertView.heightAnchor.constraint(equalToConstant: 60)
        let w = alertView.widthAnchor.constraint(equalToConstant: screenSize.width - 80)

        view.addSubview(alertView)
        NSLayoutConstraint.activate([x,y,h,w])


        alertView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.25, animations: {
           alertView.transform = CGAffineTransform(scaleX: 1, y: 1)

        }) { bool in
         
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                alertView.alpha = 1
                alertView.transform = CGAffineTransform(scaleX: 1, y: 1)
                UIView.animate(withDuration: 0.2, animations: {
                    alertView.alpha = 0.1
                    alertView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                }) { bool in
                    
                    if bool { alertView.removeFromSuperview() }
                }
            }
        }
    }
    
    
}
