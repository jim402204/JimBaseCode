//
//  NibInitializable.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public protocol NibInitializable: NibLoadable {}

public extension NibInitializable where Self: UIView {
    static func instanciateFromNib() -> Self {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? Self else {
            fatalError("Could not instantiate view with nib name: \(nibName)")
        }
        return view
    }
}
