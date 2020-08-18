//
//  SearchSpotifyDataStore.swift
//  project
//
//  Created by tranthanh on 7/16/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

struct Video : Codable {
    
   
    
    var album : AlbumSpoty!
    var artists : [ArtistsSpoty]!
    var discNumber : Int!
    var durationMs : Int!
    var explicit : Bool!
    var href : String!
    var id : String!
    var name : String!
    var popularity : Int!
    var previewUrl : String!
    var trackNumber : Int!
    var type : String!
    var uri : String!
    var total_tracks : Int!
    var images : [ImageSpoty]!
    
    
    var img_thumb : String = ""
    var img_banner: String = ""
    var song_url : String = ""
    var duration : Int = 0
    var release_date : String = ""
    var created_at : String = ""
    var updated_at : String = ""
    var descriptionInfor: String = ""
    var position: Int = 0
    var song_name_1 : String = ""
    var song_name_2 : String = ""
    var song_name_3 : String = ""
    var artist_id : Int = 0
    var isArtist  : Bool = true
    var isBanner  : Bool = false
    var songs_count : Int = 0
    var isPlaying = false
    var icon : String = ""
    
    
    var etag : String!
    var idKaraoke : IdKaraoke!
    var kind : String!
    var snippet :  SnippetKaraoke!

    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(json: JSON!){
        if json.isEmpty{
            return
        }
        album = AlbumSpoty(json: json["album"]) 
        let artistsArray = json["artists"].arrayValue
        artists = artistsArray.map{(ArtistsSpoty(json: $0))}
        discNumber = json["disc_number"].intValue
        durationMs = json["duration_ms"].intValue
        explicit = json["explicit"].boolValue
        href = json["href"].stringValue
        
        id = json["id"].stringValue
        etag = json["etag"].stringValue
        idKaraoke  = IdKaraoke(json: json["id"])
        kind = json["kind"].stringValue
        snippet = SnippetKaraoke(fromJson:  json["snippet"])
        
    
               
        
        
        name = json["name"].stringValue
        popularity = json["popularity"].intValue
        previewUrl = json["preview_url"].stringValue
        trackNumber = json["track_number"].intValue
        type = json["type"].stringValue
        uri = json["uri"].stringValue
        total_tracks = json["total_tracks"].intValue
        let imagesArray = json["images"].arrayValue
        self.images = imagesArray.map{ (ImageSpoty(json: $0))}
        
        self.img_thumb = json["img_thumb"].stringValue
        self.song_url = json["song_url"].stringValue
        self.duration = json["duration"].intValue
        self.release_date = json["release_date"].stringValue
        self.created_at = json["created_at"].stringValue
        self.updated_at =  json["updated_at"].stringValue
        self.img_banner = json["img_banner"].stringValue
        self.position = json["position"].intValue
        self.descriptionInfor = json["description"].stringValue
        self.song_name_1 = json["song_name_1"].stringValue
        self.song_name_2 = json["song_name_2"].stringValue
        self.song_name_3 = json["song_name_3"].stringValue
        self.songs_count = json["songs_count"].intValue
        self.icon       = json["icon"].stringValue
    }
    
}


struct ArtistsSpoty : Codable {
    
    var href : String!
    var id : String!
    var name : String!
    var type : String!
    var uri : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(json: JSON!){
        if json.isEmpty{
            return
        }
        href = json["href"].stringValue
        id = json["id"].stringValue
        name = json["name"].stringValue
        type = json["type"].stringValue
        uri = json["uri"].stringValue
    }
}

struct ImageSpoty : Codable {
    
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
struct AlbumSpoty : Codable {
    
    
    var albumType : String!
    var artists : [ArtistsSpoty]!
    var href : String!
    var id : String!
    var images : [ImageSpoty]!
    var name : String!
    var releaseDate : String!
    var releaseDatePrecision : String!
    var totalTracks : Int!
    var type : String!
    var uri : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(json: JSON!){
        if json.isEmpty{
            return
        }
        albumType = json["album_type"].stringValue
        let artistsArray = json["artists"].arrayValue
        self.artists = artistsArray.map{ (ArtistsSpoty(json: $0))}
        href = json["href"].stringValue
        id = json["id"].stringValue
        let imagesArray = json["images"].arrayValue
        self.images = imagesArray.map{ (ImageSpoty(json: $0))}
        name = json["name"].stringValue
        releaseDate = json["release_date"].stringValue
        releaseDatePrecision = json["release_date_precision"].stringValue
        totalTracks = json["total_tracks"].intValue
        type = json["type"].stringValue
        uri = json["uri"].stringValue
    }
}

struct AccessToken : Codable {
    var accesstoken: String! = ""
    var key: String! = ""
    var number_of_key: Int! = 0
    
    
    init() {
        
    }
    init(json: JSON!){
        if json.isEmpty{
            return
        }
        accesstoken = json["access-token"].stringValue
        key = json["key"].stringValue
        number_of_key = json["number_of_key"].intValue
        
    }
    
    
}

struct YouTubeKeySpoty  {
    
    var youtubeId : String!
    var youtubeKey : String!
    
    init() {
        
    }
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(json: JSON!){
        if json.isEmpty{
            return
        }
        youtubeId = json["youtube_id"].stringValue
        youtubeKey = json["youtube_key"].stringValue
    }
    
}

class SearchSpotifyDataStore {
    static var share = SearchSpotifyDataStore()
    //"https://api.spotify.com/v1/search?q=em%20gai%20mua&type=track&maker=US&limit=50&offset=07"
    
    let baseurl = "https://api.spotify.com/v1/search"
    func getStatusTrans(q : String , type : String , maker : String , accesstoken : String , responses : @escaping (_ track : [Video]?)->()){
        let urlRequest = baseurl
        let param : [String : Any] = [
            "q": q,
            "type":  type,
            "maker": maker,
            "limit": 50,
            "offset": 0
        ]
        
        let headers = [
            "Authorization": "Bearer \(accesstoken)"
        ]
        
        var tracks = [Video]()
        Alamofire.request(urlRequest, method: .get, parameters: param, encoding: URLEncoding.default, headers: headers).responseJSON(queue: DispatchQueue.main, options: .allowFragments) { ( response) in
            print("Respone Description:\n\(response.description)")
            switch response.result {
                
            case .success(let result):
                let result = JSON(result)
                if type == "album" {
                    let arraytrack = result["albums"]["items"].arrayValue
                     tracks = arraytrack.map{ (Video(json: $0))}
                }else{
                    let arraytrack = result["tracks"]["items"].arrayValue
                     tracks = arraytrack.map{ (Video(json: $0))}
                }
            case .failure(let error):
                print(error)
            }
            responses(tracks)
        }
    }
    
    //http://54.254.136.143/grafsound-tv/backend/web/index.php/api/test/spotify-access-token
    
    var urlAccessToken = "http://54.254.136.143/grafsound-tv/backend/web/index.php/api/test/spotify-access-token"
    func getAccesstoken(responses : @escaping (_ accesstoken : AccessToken?)->()){
        let urlRequest = urlAccessToken
        
        var accesstoken = AccessToken()
        Alamofire.request(urlRequest, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(queue: DispatchQueue.main, options: .allowFragments) { ( response) in
            switch response.result {
            case .success(let result):
                let result = JSON(result)
                let jsonData = result["data"]
                accesstoken = AccessToken(json: jsonData)
            case .failure(let error):
                print(error)
            }
            responses(accesstoken)
        }
    }
    //http://54.254.136.143/grafsound-tv/backend/web/index.php/api/song/get-youtube-id?keyword=Chasin%27%20You%20Morgan%20Wallen&spotify_track_id=5MwynWK9s4hlyKHqhkNn4A
    
    func getYoutubeIdSporty(keyword : String , spotify_track_id : String , responses : @escaping (_ item : YouTubeKeySpoty?)->()){
        let urlvideoidSpoty = "http://54.254.136.143/grafsound-tv/backend/web/index.php/api/song/get-youtube-id"
        var youTubeKeySpoty = YouTubeKeySpoty()
        
        let param : [String : Any] = [
            "spotify_track_id ": spotify_track_id ,
            "keyword":  keyword
        ]
        
        Alamofire.request(urlvideoidSpoty, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON(queue: DispatchQueue.main, options: .allowFragments) { ( response) in
            switch response.result {
            case .success(let result):
                let result = JSON(result)
                let jsonData = result["data"]
                youTubeKeySpoty = YouTubeKeySpoty(json: jsonData)
            case .failure(let error):
                print(error)
            }
            responses(youTubeKeySpoty)
        }
    }
    
    
    
    
}
