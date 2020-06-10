//
//  UINavigationController+Extensions.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public extension UINavigationController {
    var rootViewController: UIViewController? {
        return viewControllers.first
    }
    
    func typeCastingOfRootViewController<T: UIViewController>() -> T {
        guard let viewController = rootViewController as? T else {
            fatalError("Could not type casting with: \(T.self)")
        }
        return viewController
    }
}

// MARK: Pop to that ViewController

public extension UINavigationController {
    
    func navigationGoBack<T: UIViewController>(to controller: T.Type) {
        
        for lastViewController in self.viewControllers {
            
            if lastViewController is T{
                self.popToViewController(lastViewController, animated: true)
            }
        }
        
    }
    
    func getNavigationVC<T: UIViewController>(to controller: T.Type) -> T? {
        
        for lastViewController in self.viewControllers {
            
            if lastViewController is T{
                return lastViewController as? T
            }
        }
        return nil
    }
    
}

// MARK: Push & Pop Complication

public extension UINavigationController {
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool,
                            completion: (() -> Void)?) {
        pushViewController(viewController, animated: animated)
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
    
    func popViewController(animated: Bool,
                           completion: (() -> Void)?) {
        popViewController(animated: animated)
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
    
    func popToViewController(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)?) {
        popToViewController(viewController, animated: animated)
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
}
