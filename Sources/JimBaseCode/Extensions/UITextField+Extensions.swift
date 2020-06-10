//
//  UITextField+Extensions.swift
//  dsb
//
//  Created by Jim on 2020/3/27.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public extension UITextField {
    
    func addToolBar() {
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()
        toolbar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        let doneButtonItem = UIBarButtonItem(title: "確定", style: .done, target: self, action: #selector(closeKeyBoard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButtonItem], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    @objc fileprivate func closeKeyBoard() {
        
        let windowVC = UIApplication.shared.topViewController()
        windowVC?.view.endEditing(true)
    }
}

public extension UITextField {
    
    //加入一個date picker
    func setInputViewDatePicker() -> CustomDatePicker {
      
        let screenWidth = UIScreen.main.bounds.width
        let datePicker: CustomDatePicker = CustomDatePicker.instanciateFromNib()
//        datePicker.translatesAutoresizingMaskIntoConstraints = false
//        datePicker.heightAnchor.constraint(equalToConstant: 240)
        
        self.inputView = datePicker
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
//        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(tapFinal)) //7
        toolBar.setItems([flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
        
        return datePicker
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
    @objc func tapFinal() {
        
        let picker = self.inputView as? CustomDatePicker
        self.text = picker?.dateString
        
        self.resignFirstResponder()
    }
    
}

public extension UITextField {
    
    //加入一個date picker
    func setPicker() -> (SelectedPickerProtocol , UIPickerView, UIBarButtonItem) {
      
        let screenWidth = UIScreen.main.bounds.width
//        let datePicker: CustomDatePicker = CustomDatePicker.instanciateFromNib()
        
        let pickerProtocol = SelectedPickerProtocol()
//        pickerProtocol.models = options
        
        let picker = UIPickerView()
        picker.delegate = pickerProtocol
        picker.dataSource = pickerProtocol
        
        self.inputView = picker
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
//        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(selectedFinal)) //7
        toolBar.setItems([flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
        
        return (pickerProtocol,picker,barButton)
    }
    
//    @objc func selectedCancel() {
//        self.resignFirstResponder()
//    }
    
    @objc func selectedFinal() {
        
        guard let textField = self as? DisableTextField else { return }
        guard let picker = textField.optionPickerProtocol else { return }
        
        textField.clickDelegate?.didClick(item: textField, pickObj: picker, selected: picker.currentSelectedItem)
        
        
//        print("picker?.currentSelectedName: \(picker?.currentSelectedName)")
//        self.text = picker?.currentSelectedName == "" ? picker?.models.first?.optionName : picker?.currentSelectedName
        
        self.text = picker.currentSelectedName
        self.resignFirstResponder()
    }
    
}
