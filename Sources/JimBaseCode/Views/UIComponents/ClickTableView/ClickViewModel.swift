//
//  ClickViewModel.swift
//  dsb
//
//  Created by Jim on 2020/4/1.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import Foundation

public class ClickViewModel {
    
    var hintText: String = ""
    var texts:[String] = []
    
    var showOptionViewModel: [String] {
        
        if hintText != "" {
            texts.insert(hintText, at: 0)
        }
        return texts
    }
    
    init(hintText: String,tag: Int? = nil) {
        self.hintText = hintText
    }
    
    init() {
        
    }
    
}
