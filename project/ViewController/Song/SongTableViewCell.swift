//
//  SongTableViewCell.swift
//  project
//
//  Created by tranthanh on 4/18/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import MediaPlayer
 protocol ItemSongCollectionDelegate : class {
    func onShowActionMenu(actionMenu: UIAlertController)
    func onItemClicked(index: Int)
    func onItemDeleted(item: SongItem)
 }



class SongTableViewCell: UITableViewCell {
    weak var delegate: ItemSongCollectionDelegate?

    @IBOutlet weak var imageSong: UIImageView!
    @IBOutlet weak var lblNameSong: UILabel!
    @IBOutlet weak var lblNameArtist: UILabel!
    @IBOutlet weak var imageMore: UIImageView!
    @IBOutlet weak var imgMore: UIImageView!
    @IBOutlet weak var btnMore: UIButton!
    var index: Int!
    var item: SongItem!
    var itemSongAlbum :  SongItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        Utilities.createTextColor(for: lblNameSong,lblNameArtist, color: UIColor(Colors.primaryTextColor))
        btnMore.isEnabled = false
        imgMore.isHidden = true
    
    }
    
    func bind(index: Int, item: SongItem) {
           self.item = item
           self.index = index
           lblNameSong.text = item.songName
           lblNameArtist.text = item.artistName
           guard let imgData = item.imageSound else {return}
           imageSong.image = UIImage(data: imgData)
    }
    
   
    @IBAction func actionItemClicked(_ sender: UIButton) {
        delegate?.onItemClicked(index: self.index)
    }
    
       
    
    @IBAction func btnMoreAction(_ sender: Any) {
        showActionMenu(item: self.item)
    }
    
    private func showActionMenu(item: SongItem){
           let actionMenuAlert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
           let actionDeleteSong = UIAlertAction(title: "Delete", style: .default) { (_) in
            self.delegate?.onItemDeleted(item: item)
           }
           let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
               
           }
           actionMenuAlert.addAction(actionDeleteSong)
           actionMenuAlert.addAction(actionCancel)

           delegate?.onShowActionMenu(actionMenu: actionMenuAlert)
           
       }
       
    
    
}
