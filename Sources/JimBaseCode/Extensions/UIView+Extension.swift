//
//  UIView+Extension.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

// MARK: layout相關

public extension UIView {
    /// SwifterSwift: Anchor all sides of the view into it's superview.
    @available(iOS 9, *)
    func fillToSuperview() {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
    
    func layout(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let view = superview {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.topAnchor, constant: top),
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottom),
                leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
                rightAnchor.constraint(equalTo: view.rightAnchor, constant: -right),
            ])
        }
    }
    
    /// SwifterSwift: Load view from nib.
    ///
    /// - Parameters:
    ///   - name: nib name.
    ///   - bundle: bundle of nib (default is nil).
    /// - Returns: optional UIView (if applicable).
    class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    func removeALLGesture() {
        if let gestureRecognizers = self.gestureRecognizers {
            for gesture in gestureRecognizers {
                self.removeGestureRecognizer(gesture)
            }
        }
    }
    
}

// MARK: 點擊用tableView相關

public extension UIView {
    
    var bHeight: CGFloat {
        return self.bounds.height
    }
    
    var bWidth: CGFloat {
        return self.bounds.width
    }
    
    func addOptionView(viewModel: ClickViewModel, options: [String], vc: UIView, tableViewProtocrl: ClickTableViewProtocol, resizeWidth: CGFloat? = nil) {
        
        let viewModel = viewModel
        viewModel.texts = options
        
        tableViewProtocrl.viewModels = viewModel.showOptionViewModel
        self.addClickTableView(vc: vc, tableConfig: tableViewProtocrl, resizeWidth: resizeWidth)
    }
    
    /// 在viewController 加一個可以選擇項目的tablewView  目前add的方式是fram
    func addClickTableView(vc: UIView, tableConfig: ClickTableViewProtocol, resizeWidth: CGFloat? = nil) {
        
        let view = self
        var origin = CGPoint(x: view.frame.minX - 10, y: view.frame.minY)
        var size = CGSize(width: view.bWidth + 20, height: view.bHeight * 4)
        
        //重定義大小
        if let resizeWidth = resizeWidth {
            size = CGSize(width: resizeWidth, height: view.bHeight * 4)
        }
//        ClickTableViewCell.setFontSize = 13
        
        //加在tableView上
        if view.frame.origin == .zero {
            if let stackView = view.superview as? UIStackView {
                origin = CGPoint(x: stackView.frame.minX - 10, y: stackView.frame.minY)
            }
        }
        
        let tableView = UITableView(frame: CGRect(origin: .zero, size: size), style: .plain)
        tableView.backgroundColor = .lightGray
        tableView.layer.cornerRadius = 15
        tableView.frame.origin = origin
        tableView.rowHeight = view.bHeight
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(ClickTableViewCell.self)
        tableView.dataSource = tableConfig
        tableView.delegate = tableConfig
        
        let shadowView = tableView.addInShadowView()
            
        shadowView.animateShow(addToView: vc)
        
        print("origin: \(origin)")
//        shadowView.frame.origin = origin
    }
    
    func addInShadowView() -> UIView {
        
        let viewFrame = CGRect(origin: self.frame.origin, size: self.frame.size)
        let shadowView = ShadowView(frame: viewFrame)
        
        shadowView.addSubview(self)
        self.fillToSuperview()
        
        return shadowView
    }
    
    /// 對view加陰影
    /// - Parameter color: 自訂顏色
    func addShadow(with color: UIColor = .black) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
}

// MARK: 點擊用tableView動畫相關

public extension UIView {
    
    func getShadowView() -> ShadowView? {
        
        guard let shadowView = self.superview as? ShadowView  else { return nil }
        return shadowView
    }
    
    func animateShow(addToView: UIView) {
        
        //第一次是add之後 是顯示 透過加tag 來判斷是室是否第一次
        guard self.tag != 11111 else { return animate(.show) }
        self.tag = 11111
        
        animateStart {
            addToView.addSubview(self)
        }
    }
    
    enum AnimateType {
        case show
        case hide
        case dismiss
    }
    
    func animate(_ display: AnimateType) {
        
        switch display {

        case .show:
            animateStart {
                self.isHidden = false
            }
        case .hide:
            
            animateEnd {
                self.isHidden = true
            }
        case .dismiss:
            animateEnd {
                self.removeFromSuperview()
            }
        }

    }
    
    func animateStart(done: (()->())? = nil) {
        
        self.alpha = 0.3
        
        UIView.animate(withDuration: 0.25) {

            done?()
            self.alpha = 1
        }
    }
    
    func animateEnd(done: (()->())? = nil) {
        
        self.alpha = 1
        
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0.1
        }) { bool in
            if bool { done?() }
        }
    }
    
    /// 類似android的Toast    addView進去 經過一陣子會消失
    /// - Parameters:
    ///   - showTime: 動畫時間
    ///   - delayTime: 經過多久後消失
    ///   - constraints: 有默認的 constraints
    func showToast(_ showTime: TimeInterval = 1, delayTime: TimeInterval = 0.5, addToVC viewController: UIViewController, constraints: [NSLayoutConstraint]? = nil) {
        
        let y = self.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        let x = self.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor)
        let h = self.heightAnchor.constraint(equalToConstant: 100)
        let w = self.widthAnchor.constraint(equalToConstant: 100)
        
        var layoutConstraint:[NSLayoutConstraint] = []
        
        if let constraints = constraints {
            layoutConstraint = constraints
        } else {
            layoutConstraint = [x,y,h,w]
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.alpha = 0.3
        UIView.animate(withDuration: showTime, animations: {
            self.alpha = 1
            viewController.view.addSubview(self)
            NSLayoutConstraint.activate(layoutConstraint)
        }) { bool in
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayTime) {
                
                self.alpha = 1
                UIView.animate(withDuration: showTime, animations: {
                    self.alpha = 0.0
                }) { bool in
                     
                    if bool { self.removeFromSuperview() }
                }
            }
        }
    }
    
}
