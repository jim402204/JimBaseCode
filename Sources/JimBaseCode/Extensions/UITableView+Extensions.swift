//
//  UITableView+Extensions.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: NibLoadable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func register<T: UITableViewHeaderFooterView>(_: T.Type) where T: NibLoadable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue header footer view with identifier: \(T.reuseIdentifier)")
        }
        return headerFooterView
    }
    
    func cellForRow<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = cellForRow(at: indexPath) as? T else {
            fatalError("Could not get cell with identifier: \(T.reuseIdentifier) and indexPath: \(indexPath)")
        }
        return cell
    }
    
    func cellForRow<T: UITableViewCell>(type: T.Type,at indexPath: IndexPath) -> T? {
        
        return cellForRow(at: indexPath) as? T
    }
    
}

public extension UITableView {
    func updateUserInterface(_ closure: (()->())?) {
        beginUpdates()
        closure?()
        endUpdates()
    }
    
    /// SwifterSwift: Scroll to bottom of TableView.
    ///
    /// - Parameter animated: set true to animate scroll (default is true).
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    func scrollToTop(animated: Bool = true) {
        
        setContentOffset(CGPoint(x: 1, y: 1), animated: animated)
        
//        scrollRectToVisible(CGRect(origin: CGPoint(x: 1, y: 1), size: CGSize(width: 1, height: 1)), animated: true)
    }
    
    
}

public extension UITableView {
    
    func setAndLayoutTableHeaderView(header: UIView) {
        //先找到 設定好刷新 在抓在設定。但是我一開始的高就是過高的
        self.tableHeaderView = header
        
        for view in header.subviews {
            guard let label = view as? UILabel, label.numberOfLines == 0 else { continue }
            label.preferredMaxLayoutWidth = label.frame.width
        }
        header.setNeedsLayout()
        header.layoutIfNeeded()
        var frame = header.frame
        
        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        frame.size = size
        
        header.frame = frame
        self.tableHeaderView = header
    }
    
}

public extension UITableViewCell {
    func superTableView() -> UITableView? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let tableView = view as? UITableView {
                return tableView
            }
        }
        return nil
    }
}

public extension UITableView {
    
    func chabgeContentSize(newWidth: CGFloat) {
        var contentSize = self.contentSize
        contentSize.width = newWidth
        self.contentSize = contentSize
    }
    
}
