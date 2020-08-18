//
//  CellAlbumMp3.swift
//  project
//
//  Created by tranthanh on 5/11/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import MediaPlayer

class CellAlbumMp3: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coutLabel: UILabel!

     @IBOutlet weak var  labelMusicTitle: UILabel!
     @IBOutlet weak var  labelMusicDescription: UILabel!
    var index: Int!
       var item: AlbumOff!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    func bind(index: Int, item: AlbumOff) {
        self.item = item
        self.index = index
        nameLabel.text = item.name
        labelMusicDescription.text = item.artistName
        coutLabel.text = item.itemCount
        guard let imgData = item.imageSound else {return}
        imgView.image = UIImage(data: imgData)
    }
    
   
    
    
    
}
