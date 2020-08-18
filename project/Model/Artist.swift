//
//  Service.swift
//  project
//
//  Created by Trang Pham on 11/14/18.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import Foundation
import SwiftyJSON

class Artist : NSObject, NSCoding {
   
    
    var id: String = ""
    var title: String = ""
    var image: String = ""
    var banner: String = ""
    var real_name: String = ""
    var is_active: Int = 1
   // var description: String
    var location: String = ""
    var birth_date: String = ""
    var count: Int = 1
    var songs: [Song] = [Song]()

    init(title: String, count: Int) {
        self.title = title
        self.count = count
        self.image = ""
        self.banner = ""
        self.real_name  = ""
        self.is_active = 1
     //   self.description = ""
        self.location = ""
        self.birth_date = ""
        self.id = ""
        
    }
    
    init(id: String, title: String, image: String) {
        
        self.title = title
        self.image = image
        self.banner = ""
        self.real_name  = ""
        self.is_active = 1
        //   self.description = ""
        self.location = ""
        self.birth_date = ""
        self.id = id
        
        //
        var downloadedSong = DOWNLOADED_SONG
        for i in 0..<downloadedSong.count {
            let song = downloadedSong[i]
            for artist in song.getArtistIds(){
                if artist == self.id{
                    songs.append(song)
                }
            }
        }
        
    }
    
   
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.title = json["name"].stringValue
        self.image = json["img_thumb"].stringValue
        self.banner = json["img_banner"].stringValue
        self.birth_date = json["birth_date"].stringValue
        self.real_name = json["real_name"].stringValue
        self.is_active = json["is_active"].intValue
        self.location = json["price"].stringValue
    //    self.description = json["description"].stringValue
          
    }
    
    init(data: [String: AnyObject]) {
        if let id = data["id"] as? String {
            self.id = id
        }
        if let title = data["title"] as? String {
            self.title = title
        }
        if let image = data["image"] as? String {
            self.image = image
        }
        
        var downloadedSong = DOWNLOADED_SONG
        for i in 0..<downloadedSong.count {
            let song = downloadedSong[i]
            for artist in song.getArtistIds(){
                if artist == self.id{
                    songs.append(song)
                }
            }
        }
    }
    
    func getSongsByArtist() -> [Song] {
        var songs = [Song]()
        var downloadedSong = DOWNLOADED_SONG
        for i in 0..<downloadedSong.count {
            let song = downloadedSong[i]
            for artist in song.getArtistIds(){
                if artist == self.id{
                    songs.append(song)
                }
            }
        }
        
        return songs
    }
    
    func updateDownloadedSong()  {
        self.songs = getSongsByArtist()
    }

    public func encode() -> [String: AnyObject] {
        var dictionary : Dictionary = [String: AnyObject]()
        dictionary["id"] = id as AnyObject
        dictionary["title"] = title as AnyObject
        dictionary["count"] = count as AnyObject
        dictionary["image"] = image as AnyObject
    
        
        return dictionary
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(count, forKey: "count")
     //   aCoder.encode(songs, forKey: "songs")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let image = aDecoder.decodeObject(forKey: "image") as! String
      //  let listSongs = aDecoder.decodeObject(forKey: "songs") as! [Song]
        
        self.init(id: id, title: title, image: image)
    }
    
}
