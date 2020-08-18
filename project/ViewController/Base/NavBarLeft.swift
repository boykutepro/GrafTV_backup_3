//
//  NavBarLeft.swift
//  NewReader
//
//  Created by tranthanh on 4/9/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit


class NavBarLeft: UIView {
    
    let SIZE_OF_VIEW = 44
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var btnSearch: UIButton!
    
    
    weak var delegate : NavBarDelegate?
    var itemMenuCount : Int = 0
    var isNavBar : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setBackgroud(color: .clear)
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
    func setBackgroud(color : UIColor)  {
        contentView.backgroundColor = color
    }
    
    // MARK: config menu button
    // has 2 type for menu button now.
    // one for toggle menu, one for back navigation
    func configMenuButton(){
        if isNavBar {
            btnMenu.setImage(#imageLiteral(resourceName: "icons8-left"), for: .normal)
            btnMenu.addTarget(self, action: #selector(self.actionBackNav(_:)), for: .touchUpInside)
            btnSearch.setImage(nil, for: .normal)
            btnSearch.addTarget(self, action: #selector(self.actionSearchHidden(_:)), for: .touchUpInside)
        }else{
            btnMenu.setImage(#imageLiteral(resourceName: "icons8-menu"), for: .normal)
            btnMenu.addTarget(self, action: #selector(self.actionToggleMenu(_:)), for: .touchUpInside)
            btnSearch.setImage(#imageLiteral(resourceName: "icons8-search"), for: .normal)
            btnSearch.addTarget(self, action: #selector(self.actionSearch(_:)), for: .touchUpInside)
        }
    }
    
    @objc func actionToggleMenu(_ sender: UIButton){
        delegate?.onToggleMenuButton()
    }
    
    @objc func actionSearch(_ sender: UIButton){
        delegate?.onSearch()
    }
    @objc func actionSearchHidden(_ sender: UIButton){
        
    }
    
    @objc func actionBackNav(_ sender: UIButton){
        delegate?.onNavBack()
    }
    
    // add action view
    @objc func actionMenu(_ sender : UIButton)  {
        delegate?.onItemMenuSelected!(sender)
        
    }
    
    func updateMenuImage(tag : Int,  image : UIImage)  {
        let button = actionView.viewWithTag(tag) as! UIButton
        button.setImage(image, for: .normal)
       
    }
    
}
