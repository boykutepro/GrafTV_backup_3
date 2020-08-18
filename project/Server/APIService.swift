//
//  APIService.swift
//  project
//
//  Created by tranthanh on 4/27/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


struct APIService {
    
    static let shared = APIService()
    
   
    // MARK: -- Private Methods
    
      func urlRequest(pathURL: String) -> URL {
           let strURL = API.baseURL + pathURL
           return URL(string: strURL)!
       }
    
    func getVideoArtist(artist_id: String, list : String, page: Int = 1 , responses : @escaping (_ track : [Video]?)->()){
            let url = self.urlRequest(pathURL: API.artistDetail)
            let param = ["artist_id" : artist_id,
                        "list"       : list,
                        "page"  : page,
                        "number_per_page" : 10] as [String : AnyObject]
            var tracks = [Video]()
              
            Alamofire.request(url , method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON(queue: DispatchQueue.global(), options: .allowFragments) { ( response) in
                  switch response.result {
                  case .success(let result):
                      let result = JSON(result)
                      let jsonData = result["data"].arrayValue
                     tracks = jsonData.map{ (Video(json: $0))}
                  case .failure(let error):
                      print(error)
                  }
                  responses(tracks)
              }
          }
    
    
    
     func getVideoCategory(category_id: String, list : String, page: Int = 1 , responses : @escaping (_ track : [Video]?)->()){
             let url = self.urlRequest(pathURL: API.categoryDetail)
             let param = ["category_id" : category_id,
                         "list"       : list,
                         "page"  : page,
                         "number_per_page" : 10] as [String : AnyObject]
             var tracks = [Video]()
               
        Alamofire.request(url , method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON(queue: DispatchQueue.global(), options: .allowFragments) { ( response) in
                   switch response.result {
                   case .success(let result):
                       let result = JSON(result)
                       let jsonData = result["data"].arrayValue
                      tracks = jsonData.map{ (Video(json: $0))}
                   case .failure(let error):
                       print(error)
                   }
                   responses(tracks)
               }
    }
    
    
    func getVideoViewMore(new_release: Int, chart : Int, artist : Int , category : Int , page: Int = 1  , responses : @escaping (_ track : [Video]?)->()){
               let url = self.urlRequest(pathURL:  API.viewMore)
                let param = [
                    "new_release" : new_release,
                    "chart"  : chart,
                    "artist" : artist,
                    "category" : category,
                    "page"  : page,
                    "number_per_page" : 10
               
                ] as [String : AnyObject]
               var tracks = [Video]()
                 
          Alamofire.request(url , method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON(queue: DispatchQueue.global(), options: .allowFragments) { ( response) in
                     switch response.result {
                     case .success(let result):
                         let result = JSON(result)
                         let jsonData = result["data"].arrayValue
                        tracks = jsonData.map{ (Video(json: $0))}
                     case .failure(let error):
                         print(error)
                     }
                     responses(tracks)
                 }
      }
    
    
    
    func getSearchVideoArtist(keyword: String , page: Int = 1  , responses : @escaping (_ track : [Video]?)->()){
               let url = self.urlRequest(pathURL:  API.searchArtist)
                 let param = [
                          "keyword" : keyword,
                          "page"  : page,
                          "number_per_page" : 10
                ] as [String : AnyObject]
                      
               var tracks = [Video]()
                 
          Alamofire.request(url , method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON(queue: DispatchQueue.global(), options: .allowFragments) { ( response) in
                     switch response.result {
                     case .success(let result):
                         let result = JSON(result)
                         let jsonData = result["data"].arrayValue
                        tracks = jsonData.map{ (Video(json: $0))}
                     case .failure(let error):
                         print(error)
                     }
                     responses(tracks)
                 }
      }
    
    
      func getListVideo(playlist_id: String , page: Int = 1  , responses : @escaping (_ track : [Video]?)->()){
        let url = self.urlRequest(pathURL:  API.playlistDetail)
                  let param = [
                       "playlist_id" : playlist_id,
                       "page"  : page,
                       "number_per_page" : 10
                       ] as [String : AnyObject]
                   
                        
                 var tracks = [Video]()
                   
            Alamofire.request(url , method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON(queue: DispatchQueue.global(), options: .allowFragments) { ( response) in
                       switch response.result {
                       case .success(let result):
                           let result = JSON(result)
                           let jsonData = result["data"].arrayValue
                          tracks = jsonData.map{ (Video(json: $0))}
                       case .failure(let error):
                           print(error)
                       }
                       responses(tracks)
                   }
        }
    
    
    
    func getSettingTheme(responses : @escaping (_ track : Setting?)->()){
          let url = self.urlRequest(pathURL:  API.setting)
        
        
     
                   
          var track : Setting?
                     
              Alamofire.request(url , method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(queue: DispatchQueue.main, options: .allowFragments) { ( response) in
                         switch response.result {
                         case .success(let result):
                             let result = JSON(result)
                             let jsonData = result["data"]
                             track =  Setting(json: jsonData)
                         case .failure(let error):
                             print(error)
                         }
                         responses(track)
                     }
          }
      
    
    //http://54.254.136.143/grafsound-tv/backend/web/index.php/api/song/get-youtube-id?keyword=Please%20Turn%20Off%20The%20Lights%20Joosiq&spotify_track_id=4DIgTxIHU4tR02M6jPNKRV
    
    
    func getKeyYoutube(keyword : String , responses : @escaping (_ value :  String?)->()){
             let url = self.urlRequest(pathURL:  API.idYoutube)
        
        let param = [
                 "keyword" : keyword
             ]
                      
             var track : String?
                        
                 Alamofire.request(url , method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON(queue: DispatchQueue.global(), options: .allowFragments) { ( response) in
                            switch response.result {
                            case .success(let result):
                                let result = JSON(result)
                                let jsonData = result["data"]["youtube_id"].stringValue
                                
                                 track = jsonData
                            case .failure(let error):
                                print(error)
                            }
                            responses(track)
                        }
             }
    
    
}




