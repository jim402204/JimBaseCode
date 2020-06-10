//
//  UIStoryboard+Extensions.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    convenience init(storyboard: AppStoryboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.storyboardName, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Could not instantiate view controller with identifier: \(T.storyboardIdentifier)")
        }
        return viewController
    }
}

