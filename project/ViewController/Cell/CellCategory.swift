//
//  CellCategory.swift
//  project
//
//  Created by tranthanh on 4/16/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class CellCategory: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet var iconImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }
    
    func bind(item : Video){
        imgView.setImage(url: item.img_thumb)
        lblTitle.text = item.name
       
        iconImage.sd_setImage(with: URL(string:item.icon)) { (image, error, cacheType, imageURL) in
            self.iconImage.image = image?.withRenderingMode(.alwaysTemplate)
        }
        
        
    }

   

}


extension UIImageView {
    @IBInspectable
    var changeColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!);
            return color
        }
        set {
            let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
            self.image = templateImage
            self.tintColor = newValue
        }
    }
}
