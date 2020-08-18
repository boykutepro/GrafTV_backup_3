//
//  Constant.swift
//  
//
//  Created by SUUSOFT on 5/18/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//APPID  ca-app-pub-8105309887133821~6529376728
// UnitId ca-app-pub-8105309887133821/9882847110

import UIKit

let screenSize = UIScreen.main.bounds.size
let screenWidth = screenSize.width
let screenHeight = screenSize.height


//MARK: - Constant String
// admob
let ADMOB_APP_ID = "ca-app-pub-5983740188037809~6060372392"
let INSTERTITIAL_ID = "ca-app-pub-5983740188037809~6060372392"
//let AMOB_UNIT_ID = "ca-app-pub-8105309887133821/9882847110"

//about
let ABOUT_URL = "https://loquepega.com/"
let MORE_APP_LINK = "https://loquepega.com/"
let POLICY_LINK = "https://loquepega.com/"
let STORE_LINK = "itms://itunes.apple.com/de/app/x-gift/id839686104?mt=8&uo=4"

// in-app purchase
 let PREMIUM_PRODUCT_ID = ""

//MARK: - API
struct APISong  {
         
      static let baseURL                        = "http://konkaniapps.com/music/api/"
      static let login                            = "user/login"
      static let register                         = "api/user/register"
      static let profile                          = "user/profile"
      static let changePassword                   = "api/user/change-password"
      static let forgetPassword                   = "api/user/forget-password"
      static let homeApi                          = "home/statistics"
      static let PLAYLIST                         = "music-playlist/search"
      static let ITEM_BY_PLAYLIST                 = "music-song/get-song-by-playlist"
      static let ITEM_BY_CATEGORY                 = "music-song/get-song-by-category"
      static let CATEGORIES                       = "category/list"
      static let SEARCH                           = "music-song/search"
      static let DEVICE_REGISTER                  = "home/device-register"
      static let CHECK_PREMIUM                    = "transaction/check-premium"
      static let BUY_PREMIUM                      = "transaction/buy"
      static let LOGOUT                           = "logout"
      static let CHECK_OFFLINE_MODE               = "settings/check-offline"
      static let SETTINGS              =    "settings/settings"
      
}


struct API {
    //TODO: Base URL
    
//http://54.254.136.143/grafsound-tv/backend/web/index.php/api/utility/setting
    
     static let baseURL                        = "http://54.254.136.143/grafsound-tv/backend/web/index.php/api/"
     static let homeApiVideo                   = "home/statistics"
     static let playlistDetail                 = "playlist/detail"
     static let artistDetail                   = "artist/detail"
     static let categoryDetail                 = "category/detail"
     static let viewMore                       = "home/view-more"
     static let search                             = "search"
     static let searchArtist                      = "artist/search"
     static let setting = "utility/setting"
     static let  idYoutube = "song/get-youtube-id"
    
    
    
       //http://54.254.136.143/grafsound-tv/backend/web/index.php/api/song/get-youtube-id?keyword=Please%20Turn%20Off%20The%20Lights%20Joosiq&spotify_track_id=4DIgTxIHU4tR02M6jPNKRV
       
    
        static let login                            = "user/login"
       static let register                         = "api/user/register"
       static let profile                          = "user/profile"
       static let changePassword                   = "api/user/change-password"
       static let forgetPassword                   = "api/user/forget-password"
       static let homeApi                          = "home/statistics"
       static let PLAYLIST                         = "music-playlist/search"
       static let ITEM_BY_PLAYLIST                 = "music-song/get-song-by-playlist"
       static let ITEM_BY_CATEGORY                 = "music-song/get-song-by-category"
       static let CATEGORIES                       = "category/list"
       static let SEARCH                           = "music-song/search"
       static let DEVICE_REGISTER                  = "home/device-register"
       static let CHECK_PREMIUM                    = "transaction/check-premium"
       static let BUY_PREMIUM                      = "transaction/buy"
       static let LOGOUT                           = "logout"
       static let CHECK_OFFLINE_MODE               = "settings/check-offline"
       static let SETTINGS              = "settings/settings"
    

}





struct Constant {
    static let Success = "Success"
    static let Error    = "Error"
    static let Ok    = "OK"
    static let Message = "Thông báo"
}

struct Response {
    static let Success = "SUCCESS"
    static let Error    = "ERROR"
    static let Ok    = "OK"
}



