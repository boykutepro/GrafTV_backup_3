//
//  CellKenhYeuThich.swift
//  project
//
//  Created by tranthanh on 5/3/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class CellKenhYeuThich: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(item : Video) {
        imgView.setImage(url: item.img_thumb)
        lblTitle.text = item.name
    }
    
}
