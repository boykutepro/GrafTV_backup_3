//
//  MenuCell.swift
//  AppQuiz
//
//  Created by Taof on 8/28/19.
//  Copyright © 2019 Taof. All rights reserved.
//

import UIKit


class MenuCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       selectionStyle = .none
//        Utilities.createTextColor(for: nameLabel, color: UIColor(Colors.primaryTextColor))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        nameLabel.textColor = selected ? UIColor.yellow : UIColor.white
          
    }
    
    func bind(menu : Menu){
        iconImageView.image = UIImage(named: menu.icon)
        nameLabel.text = menu.title
    }

}
