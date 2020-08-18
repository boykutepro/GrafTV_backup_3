//
//  Application.swift
//  project
//
//  Created by Mac on 8/17/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import Foundation
import UIKit


extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
