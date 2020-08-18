//
//  BaseNavLeft.swift
//  NewReader
//
//  Created by tranthanh on 4/9/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class NavLeftViewController: BaseViewController , NavBarDelegate   {
    func onSearch() {
        
    }
    
    
    func onToggleMenuButton() {
        self.slideMenuController()?.openLeft()
    }
    
    
    var navBar = NavBarLeft()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setStatusBarColor()
        initNavBar()
    }
    
    // MARK: For NAV
    func setNavTitle(title : String)  {
        navBar.setTitle(title: title)
    }
    
    func setNavBackgroundColor(color : UIColor)  {
        navBar.setBackgroud(color: .clear)
    }
    
   
    
    func onNavBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // init nav bar
    func initNavBar(){
        self.view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
            }
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        navBar.isNavBar = isNavBar()
        navBar.delegate = self
        navBar.configMenuButton()
    }
    
    func isNavBar() -> Bool {
        return false
    }
    

    override func onChangeTheme() {
        configTheme()
    }
    
    func configTheme(){
        setNavBackgroundColor(color: UIColor.clear)
//        setStatusBarColor()
    }
    
    
}
