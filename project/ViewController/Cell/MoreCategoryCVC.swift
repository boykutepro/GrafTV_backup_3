//
//  MoreCategoryCVC.swift
//  project
//
//  Created by tranthanh on 4/21/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class MoreCategoryCVC: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func bind(item : Video){
        imgView.sd_setImage(with: URL(string: item.img_thumb), completed: nil)
        lblTitle.text = item.name
    }

}
