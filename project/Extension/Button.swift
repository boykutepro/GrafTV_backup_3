//
//  Button.swift
//  NewReader
//
//  Created by tranthanh on 3/24/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

extension UIButton {
    func roundedImage() {
           self.layer.cornerRadius = self.frame.size.width / 2
           self.clipsToBounds = true
       }
}
