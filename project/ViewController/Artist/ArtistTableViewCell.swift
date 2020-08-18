//
//  ArtistTableViewCell.swift
//  project
//
//  Created by tranthanh on 4/18/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageArtist: UIImageView!
    @IBOutlet weak var lblSong: UILabel!
    @IBOutlet weak var lblCount: UILabel!

     var delegate: ItemClickedListener!
    var index: Int!
     
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func bind(index: Int, item: Artist)  {
           self.index = index
           lblSong.text = item.title
           lblCount.text  = "\(item.songs.count) songs"
           imageArtist.sd_setImage(with: URL(string: item.image), completed: nil)
       }
    
    @IBAction func actionItemClicked(_ sender: UIButton) {
        delegate.onItemClicked(position: self.index )
    }
    
       
    
}
