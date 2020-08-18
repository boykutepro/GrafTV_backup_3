//
//  product_home.swift
//  project
//
//  Created by tranthanh on 4/27/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProductHomeGrafsound {
    
    var list_banners: [Video]
    var list_new: [Video]
    var list_charts: [Video]
    var list_artists: [Video]
    var list_genres: [Video]
   
    
    init() {
        self.list_banners = [Video]()
        self.list_new = [Video]()
        self.list_charts =  [Video]()
        self.list_artists =  [Video]()
        self.list_genres =  [Video]()
    }
    
}
