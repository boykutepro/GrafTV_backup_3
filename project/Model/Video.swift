//
//  list_new.swift
//  project
//
//  Created by tranthanh on 4/27/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import SwiftyJSON

//class Video : NSObject, NSCoding {
//    
//    
//    var id : Int = 0
//    var name : String = ""
//    var img_thumb : String = ""
//    var img_banner: String = ""
//    var song_url : String = ""
//    var duration : Int = 0
//    var release_date : String = ""
//    var created_at : String = ""
//    var updated_at : String = ""
//    var descriptionInfor: String = ""
//    var position: Int = 0
//    var song_name_1 : String = ""
//    var song_name_2 : String = ""
//    var song_name_3 : String = ""
//    var artist_id : Int = 0
//    var isArtist  : Bool = true
//    var isBanner  : Bool = false
//    var songs_count : Int = 0
//    var isPlaying = false
//    var icon : String = ""
//    
//    init() {
//        
//    }
//    
//    init(json : JSON) {
//        self.id = json["id"].intValue
//        self.name = json["name"].stringValue
//        self.img_thumb = json["img_thumb"].stringValue
//        self.song_url = json["song_url"].stringValue
//        self.duration = json["duration"].intValue
//        self.release_date = json["release_date"].stringValue
//        self.created_at = json["created_at"].stringValue
//        self.updated_at =  json["updated_at"].stringValue
//        self.img_banner = json["img_banner"].stringValue
//        self.position = json["position"].intValue
//        self.descriptionInfor = json["description"].stringValue
//        self.song_name_1 = json["song_name_1"].stringValue
//        self.song_name_2 = json["song_name_2"].stringValue
//        self.song_name_3 = json["song_name_3"].stringValue
//        self.songs_count = json["songs_count"].intValue
//        self.icon       = json["icon"].stringValue
//    }
//    
//    init(id : Int, name: String,  img_thumb: String, song_url: String) {
//        self.id = 0
//        self.name  = ""
//        self.img_thumb = ""
//        self.song_url = ""
//    }
//    
//    
//    init(id : Int,  name: String, img_thumb: String, song_url: String , img_banner : String ) {
//               self.id = id
//               self.name = name
//               self.img_thumb = img_thumb
//               self.song_url = song_url
//               self.img_banner = img_banner
//              
//    }
//    
//    
//    init(data: [String: AnyObject]) {
//           if let id = data["id"] as? Int {
//               self.id = id
//           }
//           if let name = data["name"] as? String {
//               self.name = name
//           }
//           if let img_thumb = data["img_thumb"] as? String {
//               self.img_thumb = img_thumb
//           }
//           if let song_url = data["song_url"] as? String {
//               self.song_url = song_url
//           }
//           if let img_banner = data["img_banner"] as? String {
//               self.img_banner = img_banner
//           }
//        
//        
//        
//       }
//    
//    public func encode() -> [String: AnyObject] {
//        var dictionary : Dictionary = [String: AnyObject]()
//        dictionary["id"] = id as AnyObject
//        dictionary["name"] = name as AnyObject
//        dictionary["img_thumb"] = img_thumb as AnyObject
//        dictionary["song_url"] = song_url as AnyObject
//        dictionary["img_banner"] = img_banner as AnyObject
//        return dictionary
//    }
//    
//    func encode(with aCoder: NSCoder) {
//               aCoder.encode(id, forKey: "id")
//               aCoder.encode(name, forKey: "name")
//               aCoder.encode(img_thumb, forKey: "img_thumb")
//               aCoder.encode(song_url, forKey: "song_url")
//               aCoder.encode(img_banner, forKey: "img_banner")
//             
//    }
//    
//    required convenience init?(coder aDecoder: NSCoder) {
//        let id = aDecoder.decodeObject(forKey: "id") as? Int ?? 0
//        let name = aDecoder.decodeObject(forKey: "name") as! String
//        let img_thumb = aDecoder.decodeObject(forKey: "img_thumb") as! String
//        let song_url = aDecoder.decodeObject(forKey: "song_url") as! String
//        let img_banner = aDecoder.decodeObject(forKey: "img_banner") as! String
//        self.init(id : id , name : name , img_thumb : img_thumb , song_url : song_url , img_banner : img_banner)
//        
//    }
//    
//    
//    
//}
