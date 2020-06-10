//
//  ClickTableViewProtocrl.swift
//  dsb
//
//  Created by Jim on 2020/4/1.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public protocol ClickTableViewDelegate: AnyObject {
    func didClick(row: Int, optionString: String, object: ClickTableViewProtocol)
}

public class ClickTableViewProtocol: NSObject {
    
    weak var delegate: ClickTableViewDelegate? = nil
    
    var viewModels: [String] = []
    var currentSelected: Int = 0
    
    var tag: Int = 0
}

//extension ClickTableViewProtocol {
//
//    func setModel(option: [String]) {
//
//    }
//
//    func setModel() {
//
//    }
//
//}

extension ClickTableViewProtocol: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ClickTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        cell.itemLabel.text = viewModels[indexPath.row]
        
//        cell.checkImageView.isHidden = indexPath.row == currentSelected ? false : true
        
        return cell
    }

}

extension ClickTableViewProtocol: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currentSelected = indexPath.row
        tableView.getShadowView()?.animate(.hide)
        
        let row = (indexPath.row)
//        let row = (indexPath.row - 1)
//        guard row >= 0 else { return }
        //要減掉第一個提示
        delegate?.didClick(row: row, optionString: viewModels[row], object: self)
    }
    
}

public protocol OptionModel {
    
    var optionName: String { get set }
    var optionID: Int { get set }
    
}

