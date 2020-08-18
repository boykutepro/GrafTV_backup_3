//
//  Enum.swift
//  
//
//  Created by SUUSOFT on 5/18/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import Foundation

//MARK: - Api Response
enum FFError: String {
    case server                 = "Error while connect to server"
    case parse                  = "Error while parse data"
    case none                   = ""
}

enum ResponseStatus: String {
    case success                = "SUCCESS"
    case error                  = "ERROR"
}


//MAKK: - Request API by Action
enum RequestApiBy {
    case normal                 // Tap Button, First time load view , lazy loading.. -> Send Request API
    case pullToRefresh          // Pull To Refresh -> Send Request API
}


//MARK: - Gender Type
enum Gender {
    case male
    case female
    case none
}

