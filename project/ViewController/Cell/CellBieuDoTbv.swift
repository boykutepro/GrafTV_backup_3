//
//  CellBieuDoTbv.swift
//  project
//
//  Created by tranthanh on 4/28/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class CellBieuDoTbv: UITableViewCell {

    @IBOutlet weak var titleImage: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameVideo1: UILabel!
    @IBOutlet weak var nameVideo2: UILabel!
    @IBOutlet weak var nameVideo3: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func bind(item : Video){
        imgView.sd_setImage(with: URL(string: item.img_thumb), completed: nil)
        titleImage.text = item.name
        nameVideo1.text = "1.\(item.song_name_1)"
        nameVideo2.text = "2.\(item.song_name_2)"
        nameVideo3.text = "3.\(item.song_name_3)"
    }
    
}
