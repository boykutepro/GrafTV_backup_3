//
//  Window.swift
//  NewReader
//
//  Created by tranthanh on 3/23/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
