//
//  File.swift
//  AT-Fastfood-iOS
//
//  Created by Mac on 8/11/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import Foundation

class Menu {
    var id : String
    var title : String
    var icon : String
    var status : String
    var isShowIcon : Bool
    
    init(id: String, title: String, icon : String, _ showIcon: Bool = true) {
        self.id = id
        self.title = title
        self.icon = icon
        self.status = ""
        self.isShowIcon = showIcon
    }
    

}
