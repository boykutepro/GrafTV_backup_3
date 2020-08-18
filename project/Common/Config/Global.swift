//
//  Global.swift
//  
//
//  Created by SUUSOFT on 5/18/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

struct Global {
    // Token
    static var deviceToken = ""
    static var loginToken = ""
    static let FCM_KEY_SERVER = "AIzaSyD72MkG6li0f_w9jSq9f5A_bsrp_u-3puE"
  
    
}




func getImageBackGround() -> String? {
       let myDecodedObject = UserDefaults.standard.value(forKey: kBACKGROUBNDIMAGE) as? String
       return myDecodedObject
}


func saveImageBackGround(_ value: String) {
    UserDefaults.standard.set(value, forKey: kBACKGROUBNDIMAGE)
    UserDefaults.standard.synchronize()
   
}


