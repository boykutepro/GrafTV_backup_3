//
//  SettingViewController.swift
//  project
//
//  Created by tranthanh on 5/11/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class SettingViewController: NavLeftViewController {
    
    class func newVC() -> SettingViewController {
             let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
             return storyBoard.instantiateViewController(withIdentifier: SettingViewController.className) as! SettingViewController
       }
         

    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    

}
