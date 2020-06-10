//
//  PresentViewController.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import Foundation

import UIKit

public protocol PresentViewController {}

public extension PresentViewController where Self: UIViewController {
    
    /// present的方式show，有webView的ViewController (有navigationBar)
    ///
    /// - Parameters:
    ///   - urlSrting: webView顯示的網址
    ///   - navigationTitle: 標題
    
    func presentWebVC(urlSrting: String?, htmlString: String? = nil, navigationTitle: String) {
        
//        let webViewStoryboard = UIStoryboard(storyboard: .webView)
//        let webViewVC: WebViewViewController = webViewStoryboard.instantiateViewController()
//        let baseNavigationC = UINavigationController(rootViewController: webViewVC)
//        webViewVC.navigationTitle = navigationTitle
//        webViewVC.urlString = urlSrting
//        webViewVC.htmlString = htmlString
//
//        baseNavigationC.modalPresentationStyle = .fullScreen
//        self.present(baseNavigationC, animated: true, completion: nil)
    }
    
}

