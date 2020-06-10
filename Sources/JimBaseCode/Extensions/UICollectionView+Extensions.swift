//
//  UICollectionView+Extensions.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: NibLoadable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func cellForItem<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = cellForItem(at: indexPath) as? T else {
            fatalError("Could not get cell with identifier: \(T.reuseIdentifier) and indexPath: \(indexPath)")
        }
        return cell
    }
    
    func registerReusableView<T: UICollectionReusableView>(_: T.Type, elementKind: String) where T: NibLoadable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(elementKind: String, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue Reusable Supplementary View with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    /// SwifterSwift: Reload data with a completion handler.
    ///
    /// - Parameter completion: completion handler to run after reloadData finishes.
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
}
