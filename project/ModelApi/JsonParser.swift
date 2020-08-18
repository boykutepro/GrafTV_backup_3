//
//  JsonParser.swift
//  
//
//  Created by SUUSOFT on 3/29/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import UIKit
import SwiftyJSON

struct JsonParser {
    static let shared = JsonParser()
    
    func parseStatusAndMessage(json: JSON) -> (status: String, message: String) {
           let status = json["status"].stringValue
           let message = json["message"].stringValue
           return (status, message)
    }
    func parse_home(json: JSON) -> (status: String, message: String, product_Home: ProductHomeGrafsound) {
        let tuple = parseStatusAndMessage(json: json)
        let objectData = json["data"]
        let product_Home: ProductHomeGrafsound = ProductHomeGrafsound()
        
        // banner
        var arrBannner = [Video]()
        let array_list_banners = objectData["list_banners"].arrayValue
        for itemJson in array_list_banners {
            let item = Video(json: itemJson)
            arrBannner.append(item )
        }
        product_Home.list_banners = arrBannner
        
        
        //list_new_releases
        var arrNews = [Video]()
        let list_new_releases = objectData["list_new_releases"].arrayValue
                for itemJson in list_new_releases {
                    let item = Video(json: itemJson)
                    arrNews.append(item)
                }
         product_Home.list_new = arrNews
        
        //list_charts
        var arrCharts = [Video]()
        let list_charts = objectData["list_charts"].arrayValue
                       for itemJson in list_charts {
                           let item = Video(json: itemJson)
                           arrCharts.append(item)
                       }
        product_Home.list_charts = arrCharts

        //list_artists
            var arrArtists = [Video]()
            let list_artists = objectData["list_artists"].arrayValue
                        for itemJson in list_artists {
                                  let item = Video(json: itemJson)
                                   arrArtists.append(item)
                              }
            product_Home.list_artists = arrArtists
        
        //list_genres
        
        var arrGenres = [Video]()
                   let list_genres = objectData["list_genres"].arrayValue
                               for itemJson in list_genres {
                                         let item = Video(json: itemJson)
                                          arrGenres.append(item)
                                     }
        product_Home.list_genres = arrGenres
               
        
        
        
         return (tuple.status, tuple.message, product_Home)
    }
    
    func parseDanhSachPhat(json: JSON) -> (status: String, message: String, video: [Video]) {
        let tuple = parseStatusAndMessage(json: json)
        var arrDanhSachPhat = [Video]()
        let  datas = json["data"].arrayValue
        for itemJson in  datas {
            let data = Video(json:itemJson)
            arrDanhSachPhat.append(data)
        }
        return (tuple.status,tuple.message, arrDanhSachPhat)
     }

    func parseNameDetail(json: JSON) -> (status: String, message: String, name: [String] , image : [String]) {
           let tuple = parseStatusAndMessage(json: json)
           let arrayNames =  json["data"].arrayValue.map {$0["name"].stringValue}
           let arrayImages =  json["data"].arrayValue.map {$0["img_thumb"].stringValue}
           return (tuple.status,tuple.message, arrayNames , arrayImages)
    }
    
    
    
   
    
    
    func parseOfflineMode(json: JSON) -> (status: String, message: String, is_offline: Int) {
          let status = json["status"].stringValue
          let message = json["message"].stringValue
          let is_offline = json["is_offline"].intValue
          return (status, message, is_offline)
      }
      
     
    
    
}
