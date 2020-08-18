//
//  Setting.swift
//  project
//
//  Created by thanh on 7/22/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Setting {
       var about : String!
       var faq : String!
       var help : String!
       var policy : String!
       var term : String!
       var theme : [String]!
    
    
    init(json: JSON!){
        if json.isEmpty{
            return
        }
        about = json["about"].stringValue
        faq = json["faq"].stringValue
        help = json["help"].stringValue
        policy = json["policy"].stringValue
        term = json["term"].stringValue
        theme = [String]()
               let themeArray = json["theme"].arrayValue
               for themeJson in themeArray{
                   theme.append(themeJson.stringValue)
        }
    }
}



