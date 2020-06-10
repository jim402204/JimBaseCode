//
//  secondPickerProtocol.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/4/29.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public protocol SelectedPickerProtocolDelegate: AnyObject {
    func didSelected(optionName: PickerModel, titleID: String, object: SelectedPickerProtocol)
}

public class SelectedPickerProtocol: NSObject {
    
    weak var delegate: SelectedPickerProtocolDelegate? = nil
    
    var models: [PickerModel] = [] {
        willSet {
            
        }
        
        didSet {
            //每次reload代入第一個     //預防第一次沒有滾動 又進行click確定
            currentSelectedName = models.first?.optionName ?? ""
            currentSelectedItem = models.first ?? PickerModel(optionName: "空的")
            index = 0
        }
    }
    var currentSelectedName: String = ""
    var currentSelectedItem = PickerModel(optionName: "空的")
    
    var index = 0
    var tagString = ""
}

// MARK: - UIPickerViewDataSource

extension SelectedPickerProtocol: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return models.count
    }
    
}

// MARK: - UIPickerViewDelegate

extension SelectedPickerProtocol: UIPickerViewDelegate {

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        index = row
        currentSelectedItem = models[row]
        currentSelectedName = models[row].optionName
        delegate?.didSelected(optionName: models[row], titleID: models.first?.optionName ?? "", object: self)
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = models[row].optionName
        label.textAlignment = .center
        
        return label
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return models[row].optionName
//    }
    
}

//extension selectedPickerProtocol: NibInitializable {}

public struct PickerModel {
    
    var optionName: String
    var id: String = ""
    //／新增收款碼用
    var payType: String = ""
}
