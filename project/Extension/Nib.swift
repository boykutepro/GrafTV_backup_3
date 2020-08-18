//
//  Nib.swift
//  project
//
//  Created by tranthanh on 4/20/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
protocol Nib {
    func registerNib()
}

extension Nib where Self : UIView {
    
    func registerNib() {
        guard let nibName = type(of: self).description().components(separatedBy: ".").last else { return }
        // ** Check if resource is used in Interface Builder first to avoid crash during compile
        #if !TARGET_INTERFACE_BUILDER
        let bundle = Bundle(for: type(of: self))
        guard let _ = bundle.path(forResource: nibName, ofType: "nib")
            else { fatalError("can't find \(nibName) xib resource in current bundle") }
        #endif
        guard let view = Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
            else { return }
        // ** Another way to write it but do not work if xib is bundled with framework
        //guard let view = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
        //    else { return }
        view.frame = bounds
        addSubview(view)
    }
    
}

