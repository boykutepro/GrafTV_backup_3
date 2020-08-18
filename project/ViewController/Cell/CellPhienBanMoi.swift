//
//  CellPhienBanMoi.swift
//  project
//
//  Created by tranthanh on 4/24/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

protocol ItemVideoListener : class {
    func onItemVideoClicked(index: Int)
    func onMenuOption(index: Int)
}

class CellPhienBanMoi: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var delegate:  ItemVideoListener!
    var index: Int!
       
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
     }
    
    func bind(item: Video){
        imgView.sd_setImage(with: URL(string: item.img_thumb), completed: nil)
        lblTitle.text = item.name
        
    }
    
     func bind(item: Video, index: Int) {
         self.index = index
         imgView.sd_setImage(with: URL(string: item.img_thumb), completed: nil)
         lblTitle.text = item.name
     }
    
    @IBAction func actionItemClicked(_ sender: UIButton) {
           delegate.onItemVideoClicked(index: self.index)
    }
       

}
