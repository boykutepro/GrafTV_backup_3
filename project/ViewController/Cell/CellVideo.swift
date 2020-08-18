//
//  CellVideo.swift
//  project
//
//  Created by tranthanh on 4/25/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class CellVideo: UITableViewCell {

    @IBOutlet weak var imageVideo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTheLoai: UILabel!
    
    
   
    
    weak var delegate:  ItemVideoListener?
    var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        imageView?.clipsToBounds = true
        imageView?.layer.masksToBounds = true
    }
    
   
    func bind(item: Video, index: Int) {
        self.index = index
        if item.etag.isEqual("") {
            if item.uri.isEqual(""){
                imageVideo.sd_setImage(with: URL(string: item.img_thumb), completed: nil)
            } else {
                imageVideo.sd_setImage(with: URL(string: item.album.images[0].url), completed: nil)
            }
             lblTitle.text = item.name
        } else {
            imageVideo.setImage(url: item.snippet.thumbnails.defaultImage.url)
            lblTitle.text = item.snippet.title
        }
        
       
      }
    

//    func bindSpoty(item: Video, index: Int) {
//        self.index = index
//        
//      }
    
    @IBAction func actionItemClicked(_ sender: UIButton) {
           delegate?.onItemVideoClicked(index: self.index)
    }
    

      @IBAction func moreClicked(_ sender: Any) {
        delegate?.onMenuOption(index: self.index)
      }
    
}
