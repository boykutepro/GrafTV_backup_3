//
//  SearchKaraokeDataStore.swift
//  project
//
//  Created by thanh on 7/18/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


struct TracksKaraoke {
    
     var etag : String!
     var id : IdKaraoke!
     var kind : String!
     var snippet :  SnippetKaraoke!

     /**
      * Instantiate the instance using the passed json values to set the properties values
      */
     init(json: JSON!){
         if json.isEmpty{
             return
         }
         etag = json["etag"].stringValue
         id = IdKaraoke(json: json["id"])
         kind = json["kind"].stringValue
         snippet = SnippetKaraoke(fromJson:  json["snippet"])
     }
    
}


struct SnippetKaraoke : Codable {
       var channelId : String!
       var channelTitle : String!
       var descriptionField : String!
       var liveBroadcastContent : String!
       var publishedAt : String!
       var publishTime : String!
       var thumbnails :  ThumbnailKaraoke!
       var title : String!

       /**
        * Instantiate the instance using the passed json values to set the properties values
        */
       init(fromJson json: JSON!){
           if json.isEmpty{
               return
           }
           channelId = json["channelId"].stringValue
           channelTitle = json["channelTitle"].stringValue
           descriptionField = json["description"].stringValue
           liveBroadcastContent = json["liveBroadcastContent"].stringValue
           publishedAt = json["publishedAt"].stringValue
           publishTime = json["publishTime"].stringValue
           thumbnails = ThumbnailKaraoke(json: json["thumbnails"])
           title = json["title"].stringValue
       }
}

struct  ThumbnailKaraoke  : Codable {
    var defaultImage: ImageKaraoke!
    var high : ImageKaraoke!
    var medium : ImageKaraoke!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init( json: JSON!){
        if json.isEmpty{
            return
        }
        defaultImage = ImageKaraoke(json: json["default"])
        high = ImageKaraoke(json: json["high"])
        medium = ImageKaraoke(json: json["medium"])
    }

    
}

struct  ImageKaraoke  : Codable {
      var height : Int!
       var url : String!
       var width : Int!

       /**
        * Instantiate the instance using the passed json values to set the properties values
        */
       init(json: JSON!){
           if json.isEmpty{
               return
           }
           height = json["height"].intValue
           url = json["url"].stringValue
           width = json["width"].intValue
       }
}

struct IdKaraoke  : Codable {
    
    var kind : String!
    var videoId : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(json: JSON!){
        if json.isEmpty{
            return
        }
        kind = json["kind"].stringValue
        videoId = json["videoId"].stringValue
    }
}

class SearchKaraokeDataStore {
    static var share = SearchKaraokeDataStore()
   
    //https://www.googleapis.com/youtube/v3/search?key=AIzaSyC4gQKuPdA88gkHXOvbkw6HWXwp_uz1K5I%0D&q=Karaoke%20a&part=snippet%2Cid&maxResults=50
    
    
    
    func searchKaraokeApi(key : String , q : String , part : String , maxResults : String , responses : @escaping (_ track : [Video]?)->()){
           let urlKaraoke = "https://www.googleapis.com/youtube/v3/search"
           let param : [String : Any] = [
               "key": key,
               "q": "Karaoke\(q)",
               "part":part,
               "maxResults":maxResults
           ] as [String : Any]
        
           var tracks = [Video]()
           
        Alamofire.request(urlKaraoke , method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON(queue: DispatchQueue.main, options: .allowFragments) { ( response) in
               switch response.result {
               case .success(let result):
                   let result = JSON(result)
                   let jsonData = result["items"].arrayValue
                  tracks = jsonData.map{ (Video(json: $0))}
               case .failure(let error):
                   print(error)
                
               }
               responses(tracks)
           }
       }
    
}




