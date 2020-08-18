//
//  UiApplication.swift
//  project
//
//  Created by tranthanh on 4/18/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit


extension UIApplication {
    static func mainViewController() -> ViewController? {
        return shared.keyWindow!.rootViewController  as? ViewController
    }
}
