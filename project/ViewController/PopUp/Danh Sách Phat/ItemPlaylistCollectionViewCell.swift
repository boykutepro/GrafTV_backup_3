//
//  ItemSongCollectionViewCell.swift
//  project
//
//  Created by Pham Tuan on 1/21/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import UIKit
protocol ItemCickListener {
    func onClickItem(index: Int)
}
class ItemPlaylistCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var btnItem: UIButton!
    @IBOutlet weak var lblNumberSong: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPlaylist: UIImageView!
    @IBOutlet weak var icSong: UIImageView!
    
    var delegate: ItemClickedListener!
    var index: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
    
    @IBAction func onClickItem(_ sender: Any) {
        delegate.onItemClicked(position: self.index)
    }
    
    func bindData(_ playlist: PlaylistVideo, index: Int){
        if playlist.image.isEmpty {
            self.imgPlaylist.image = UIImage(named: "placeholder")
        }else {
            self.imgPlaylist.sd_setImage(with: URL(string: playlist.image), completed: nil)
        }
        self.lblTitle.text = playlist.name
        self.lblNumberSong.text = playlist.getNumberSongText()
        self.index = index
    }
    
    func bindDataDialog(_ playlist: PlaylistVideo, index: Int){
        if playlist.image.isEmpty {
            self.imgPlaylist.image = UIImage(named: "placeholder")
        }else{
           self.imgPlaylist.sd_setImage(with: URL(string: playlist.image), completed: nil)
        }
        
        self.imgPlaylist.sd_setImage(with: URL(string: playlist.image), completed: nil)
        self.lblTitle.text = playlist.name
        self.lblTitle.textColor = UIColor.black
        self.lblNumberSong.text = playlist.getNumberSongText()
        self.lblNumberSong.textColor = UIColor.darkGray
        self.index = index
        icSong.isHidden = true
    }
}
