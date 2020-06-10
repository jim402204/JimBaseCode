//
//  CustomDatePicker.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/4/17.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

public class CustomDatePicker: UIView {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var secondPicker: UIPickerView!
    
    var secArray: [String] {
        
//        return (0...59).map { int -> String in
//            if int < 10 {
//                return "0" + String(int)
//            }
//            return String(int)
//        }
        
        return (0...59).map({ String($0) })
    }
    
    var dateString = "" {
        didSet {
//            print("dateString: \(dateString)")
           
        }
    }

    var selectedTime: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dateString) else { return -1 }
        let timeStamp = Int(date.timeIntervalSince1970) * 1000
        return timeStamp
    }
    
    var submitTime: Int {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let result = timeStamp * 1000
        return result
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        configurePickerView()
    }
    
    @IBAction func pickerChangeValue(_ sender: UIDatePicker) {
        
        dateString = sender.date.defaultString
    }
    
}

public extension CustomDatePicker {

    func configurePickerView() {
        
        secondPicker.delegate = self
        secondPicker.dataSource = self
        
        let calendar = Calendar.current
        let sec = calendar.component(.second, from: Date())
        
        secondPicker.selectRow(sec, inComponent: 0, animated: false)
        
        dateString = Date().defaultString
    }
    
    func setDate(daysForwardInt: Int) {

        if let date = datePicker.calendar.date(byAdding: .day, value: daysForwardInt, to: datePicker.date) {
            datePicker.date = date


            print("datePicker.date: \(datePicker.date)")
            dateString = date.defaultString

            datePicker.reloadInputViews()
            return
        }
    }
    
}

// MARK: - UIPickerViewDataSource

extension CustomDatePicker: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return secArray.count
    }
    
}

// MARK: - UIPickerViewDelegate

extension CustomDatePicker: UIPickerViewDelegate {

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var returnRow = String(row)
        if row < 10 {
            returnRow = "0" + String(row)
        }
        
        dateString = dateString.dropLast(2) + returnRow
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return secArray[row]
    }
    
}

extension CustomDatePicker: NibInitializable {}
