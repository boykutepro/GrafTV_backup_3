//
//  NumbericExt.swift
//  project
//
//  Created by Trang Pham on 9/14/18.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import Foundation

extension Int {
    func formatnumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))!
    }
}

extension Int64 {
    func formatnumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))!
        
        
    }
    
    
}
