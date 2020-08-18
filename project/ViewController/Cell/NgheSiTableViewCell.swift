//
//  NgheSiTableViewCell.swift
//  project
//
//  Created by tranthanh on 4/23/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class NgheSiTableViewCell: UITableViewCell {
      @IBOutlet weak var imgView: UIImageView!
     @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         selectionStyle = .none
    }

    func bind(item : Video){
        self.imgView.sd_setImage(with: URL(string: item.img_thumb) , completed: nil)
        self.lblTitle.text = item.name
    }
    

    
    
}
