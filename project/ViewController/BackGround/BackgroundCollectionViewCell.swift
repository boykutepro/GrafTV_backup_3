//
//  BackgroundCollectionViewCell.swift
//  project
//
//  Created by thanh on 7/26/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class BackgroundCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    func generateCell(image : String) {
        imgView.setImage(url: image)
//        imgView.image = image
        
    }
}
