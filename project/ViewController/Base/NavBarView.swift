//
//  NavBarView.swift
//  project
//
//  Created by Mac on 8/17/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit


class NavBarView: UIView {
    
    let SIZE_OF_VIEW = 44
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    
    
    
    var delegate : NavBarDelegate!
    var itemMenuCount : Int = 0
    var isNavBar : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setBackgroud(color: Colors.primaryColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // Performs the initial setup.
    fileprivate func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    
    // set title
    func setTitle(title : String)  {
        lblTitle.text = title
    }
    
    // set background color
    func setBackgroud(color : String = Colors.primaryColor )  {
        contentView.backgroundColor = UIColor(color)
    }
    
    // MARK: config menu button
    // has 2 type for menu button now.
    // one for toggle menu, one for back navigation
    func configMenuButton(){
        if isNavBar {
            btnMenu.setImage(#imageLiteral(resourceName: "icons8-left"), for: .normal)
            btnMenu.addTarget(self, action: #selector(self.actionBackNav(_:)), for: .touchUpInside)
        }else{
            btnMenu.setImage(#imageLiteral(resourceName: "icons8-menu"), for: .normal)
            btnMenu.addTarget(self, action: #selector(self.actionToggleMenu(_:)), for: .touchUpInside)
        }
    }
    
    @objc func actionToggleMenu(_ sender: UIButton){
        if delegate != nil {
            delegate.onToggleMenuButton()
        }
    }
    
    @objc func actionBackNav(_ sender: UIButton){
        if delegate != nil {
            delegate.onNavBack()
        }
    }
    
    //MARK : ACTION MENU
    // add action view
    
    func addActionMenu(id: Int, image : UIImage )  {
        itemMenuCount += 1
        let position =  Int(actionView.frame.size.width) - itemMenuCount * SIZE_OF_VIEW
        let button = UIButton(frame: CGRect(x: position, y: 0, width: SIZE_OF_VIEW, height: SIZE_OF_VIEW))
        button.tag = id
        button.setImage(image, for: UIControl.State.normal)
        button.tintColor = UIColor(Colors.tintColor)
        button.addTarget(self, action: #selector(actionMenu(_:)), for: .touchUpInside)
        
        actionView.addSubview(button)
        
    }
    
    func addActionMenu(button : UIButton)  {
        itemMenuCount += 1
        let position =  Int(actionView.frame.size.width) - itemMenuCount * SIZE_OF_VIEW
        let frame = CGRect(x: position, y: 0, width: SIZE_OF_VIEW, height: SIZE_OF_VIEW)
        button.frame = frame
        button.addTarget(self, action: #selector(actionMenu(_:)), for: .touchUpInside)
        
        actionView.addSubview(button)
    }
    
    @objc func actionMenu(_ sender : UIButton)  {
        if delegate != nil {
            delegate.onItemMenuSelected!(sender)
        }
    }
    
    func updateMenuImage(tag : Int,  image : UIImage)  {
        let button = actionView.viewWithTag(tag) as! UIButton
        button.setImage(image, for: .normal)
    }
    
}


@objc protocol NavBarDelegate {
    func onToggleMenuButton()
    func onNavBack()
    func onSearch()
    @objc optional func onItemMenuSelected(_ sender : UIButton)
}
