//
//  DanhSachPhatTableViewCell.swift
//  project
//
//  Created by tranthanh on 4/23/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class DanhSachPhatTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    weak var delegate:  ItemVideoListener?
    var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    @IBAction func moreAction(_ sender: Any) {
        delegate?.onMenuOption(index: self.index)
    }
    
    func bind(item : Video , index : Int) {
        self.index = index
        if item.uri.isEqual(""){
            imgView.sd_setImage(with: URL(string: item.img_thumb), completed: nil)
            lblCount.text = "\(item.songs_count)"
        } else {
            imgView.sd_setImage(with: URL(string: item.images[0].url), completed: nil)
            lblCount.text = "\(item.total_tracks ?? 0)"
        }
        
        
        lblTitle.text = item.name
        
        
    }
    
    
}
