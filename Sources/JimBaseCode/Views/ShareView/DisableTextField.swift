//
//  DisableTextField.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/4/17.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

protocol DisableTextFieldDelegate: AnyObject {
    func didClick(item: DisableTextField, pickObj : SelectedPickerProtocol, selected: PickerModel)
}

class DisableTextField: UITextField {
    
    weak var clickDelegate: DisableTextFieldDelegate? = nil
    
    @IBInspectable var daysForwardInt: Int = 0
    @IBInspectable var type: Int = 0
    
    var pickerView: CustomDatePicker!
    var optionPickerProtocol: SelectedPickerProtocol!
    var optionPicker: UIPickerView!
    var optionPickerButoonItem: UIBarButtonItem!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //隱藏游標1
        self.tintColor = .clear
        
        if type == 0 {
            addDatePicker()
        } else if type == 1 {
            addPicker()
        }
    }
    
}

extension DisableTextField {
    
    func setConfig(_ vc: UIViewController, tag: String) {
        
        self.optionPickerProtocol.delegate = vc as? SelectedPickerProtocolDelegate
        self.optionPickerProtocol.tagString = tag
    }
    
    func getSelectedName() -> String {

        return self.optionPickerProtocol.currentSelectedName
    }
    
    func getSelectedItem() -> PickerModel {

        return self.optionPickerProtocol.currentSelectedItem
    }
    
    func getSelectedIndex() -> Int {

        return self.optionPickerProtocol.index
    }
    
}

extension DisableTextField {
    
    func addDatePicker() {
        //加入datePicker
        pickerView = self.setInputViewDatePicker()
        
        if daysForwardInt != 0 {
            pickerView.setDate(daysForwardInt: daysForwardInt)
        }
        self.text = pickerView.datePicker.date.defaultString
    }
    
    func addPicker() {
        let option = self.setPicker()
        
        optionPickerProtocol = option.0
        optionPicker = option.1
        optionPickerButoonItem = option.2
    }
    
    func optionReload() {
        optionPicker.reloadComponent(0)
    }
    
}

extension DisableTextField {
    
    //隱藏游標2
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    //選取範圍為零
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    //禁止編輯事件
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.selectAll(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
}
