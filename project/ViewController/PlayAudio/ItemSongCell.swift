//
//  ItemSongCell.swift
//  project
//
//  Created by Trang Pham on 1/17/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import UIKit

protocol ItemSongListener : class {
    func onItemSongClicked(index: Int)
    func onMenuOption(intdex: Int)
}


class ItemSongCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
   
    @IBOutlet weak var imgSong: UIImageView!
    @IBOutlet weak var btnAction: UIButton!
    
   weak var delegate: ItemSongListener?
    var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(item: Song, index: Int)  {
        self.index = index
        lblTitle.text = item.title
        lblAuthor.text = item.getArtist()
        imgSong.sd_setImage(with: URL(string: item.image), completed: nil)
    }
    
    @IBAction func actionItemClicked(_ sender: UIButton) {
        delegate?.onItemSongClicked(index: self.index)
    }
    
    @IBAction func actionMore(_ sender: UIButton) {
        delegate?.onMenuOption(intdex: self.index)
    }
    
}
