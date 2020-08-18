//
//  CellBieuDo.swift
//  project
//
//  Created by tranthanh on 4/24/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class CellBieuDo: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageHinh: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func bind(item: Video){
           imageHinh.sd_setImage(with: URL(string: item.img_thumb), completed: nil)
           lblTitle.text =  item.name
       }
       

}
