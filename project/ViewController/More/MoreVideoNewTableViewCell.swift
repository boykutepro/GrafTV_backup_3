//
//  MoreVideoNewTableViewCell.swift
//  project
//
//  Created by thanh on 7/20/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class MoreImageVideoTableViewCell: UITableViewCell {

     var clickBack : (()->())?
     var clickHeart : ((UIButton)->())?
   
     @IBOutlet weak var imgContainer: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func heartButton(_ sender: Any) {
        self.clickHeart?(heartButton)
    }
   
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBAction func backButton(_ sender: Any) {
        self.clickBack?()
    }
    
    @IBOutlet weak var heartButton: UIButton!
    
    func checkFavorited(item : Video) {
            if FAVORITED_CHART.contains(where: { $0.id == item.id }) {
               self.heartButton.setImage(UIImage(named: "icons8-red_heart"), for: .normal)
            } else {
                self.heartButton.setImage(UIImage(named: "icons8-heart_outline"), for: .normal)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindCell(item : Video) {
        self.imgView.setImage(url: item.img_thumb)
        self.imgContainer.setImage(url: item.img_thumb)
        self.lblTitle.text = item.name
    }

    
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
