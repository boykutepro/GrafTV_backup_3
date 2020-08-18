//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func subString(from: Int, to: Int) -> String {
       let startIndex = self.index(self.startIndex, offsetBy: from)
       let endIndex = self.index(self.startIndex, offsetBy: to)
       return String(self[startIndex...endIndex])
    }
    
    var length: Int {
        return self.count
    }
    
    func getDateFromDateTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm"
        dateFormatter.locale = Locale(identifier: "en_GB")
        let date = dateFormatter.date(from: self)
        return date!
    }
    
    func getStringDateFromTimeStamp() -> String {
        let timeInterval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timeInterval!)
        let string = date.getStringFromDateTime()
        return string
    }
    

    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.currencySymbol = "$"
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
       
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
       // let double = (amountWithPrefix as NSString).doubleValue
       // number = NSNumber(value: (double / 100))
        number = NSNumber(value: Int64(amountWithPrefix)!)
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
}
