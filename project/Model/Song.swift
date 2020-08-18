//
//  Service.swift
//  project
//
//  Created by Trang Pham on 11/14/18.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import Foundation
import SwiftyJSON

class Song : NSObject, NSCoding{
    var id: String = ""
    var title: String = ""
    var image: String = ""
    var file: String = ""
    var url: String = ""
    var is_active: Int = 1
    var content: String = ""
    var release_date: String = ""
    var price: Int = 0
    var count_views: Int = 0
    var count_rates: Int = 0
    var artistName = ""
    var duration = 0
    var artWork: UIImage?
    var type = "" // 0 is online, 1 is device, 2 is downloaded.
    var artistId = ""
    var artists = [Artist]()
    
    init(title: String, artist: String, artwork: UIImage, url: String, type: String) {
        self.id = ""
        self.title = title
        self.image = ""
        self.file = url
        self.url = url
        self.release_date = ""
        self.is_active = 0
        self.price = 0
        // self.description = ""
        self.count_views = 0
        self.count_rates = 0
        self.artistName = artist
        self.artWork = artwork
        self.type = type
    }
    
    init(title: String, artist: String, image: String,url: String, type: String) {
        self.id = ""
        self.title = title
        self.image = image
        self.file = ""
        self.url = url
        self.release_date = ""
        self.is_active = 0
        self.price = 0
       // self.description = ""
        self.count_views = 0
        self.count_rates = 0
        self.artistName = artist
        self.type = type
    }
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.title = json["name"].stringValue
        self.image = json["img_thumb"].stringValue
        self.file = json["song_file"].stringValue
        self.url = json["song_url"].stringValue
        self.release_date = json["release_date"].stringValue
        self.is_active = json["is_active"].intValue
        self.price = json["price"].intValue
        self.content = json["description"].stringValue
        self.count_views = json["count_views"].intValue
        self.count_rates = json["count_rates"].intValue
        let artistsJson = json["musicArtists"].arrayValue
        
     
        for item in artistsJson {
            let object = Artist(json: item)
            artists.append(object)
        }
        
        var artistStr = ""
        for item in artists{
            artistStr = artistStr + item.title + ","
            artistId += item.id + ","
        }
        if !artistId.isEmpty {
            artistId.removeLast()
        }
        
        if !artistStr.isEmpty {
            self.artistName = artistStr.substring(to: artistStr.index(before: artistStr.endIndex))
        }
        
    }
    
    init(id: String, title: String, image: String, file: String, artistName: String, type: String, artistId: String) {
        self.id = id
        self.title = title
        self.image = image
        self.file = file
        self.price = 0
        self.artistName = artistName
        self.type = type
        self.artistId = artistId
        
    }
    
    func getArtist() -> String {
       
        return artistName
    }
    
    func getArtistIds() -> [String] {
        var idsList = [String]()
        let ids = artistId.split(separator: ",")
        for item in ids {
            idsList.append(String(item))
        }
        return idsList
    }
    
    func getUrl() -> URL? {
        if type == "2" {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(file)
            return fileURL
        }
        
        return URL(string: file)
    }
    
    func getThumbnail() -> URL {
        
        return URL(string: image)!
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
        if let file = data["file"] as? String {
            self.file = file
        }
        if let image = data["image"] as? String {
            self.image = image
        }
        if let content = data["description"] as? String {
            self.content = content
        }
        
        if let artistName = data["artistName"] as? String {
            self.artistName = artistName
        }
        
        if let type = data["type"] as? String {
            self.type = type
        }
        
        if let artistId = data["artistId"] as? String {
            self.artistId = artistId
        }
       
    }
    
    public func encode() -> [String: AnyObject] {
        var dictionary : Dictionary = [String: AnyObject]()
        dictionary["id"] = id as AnyObject
        dictionary["title"] = title as AnyObject
        dictionary["artistName"] = artistName as AnyObject
        dictionary["file"] = file as AnyObject
        dictionary["image"] = image as AnyObject
        dictionary["description"] = content as AnyObject
        dictionary["type"] = type as AnyObject
        dictionary["artistId"] = artistId as AnyObject
    
        return dictionary
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(file, forKey: "file")
        aCoder.encode(artistName, forKey: "artistName")
        aCoder.encode(content, forKey: "description")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(artistId, forKey: "artistId")
        
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let image = aDecoder.decodeObject(forKey: "image") as! String
        let file = aDecoder.decodeObject(forKey: "file") as! String
        let artistName = aDecoder.decodeObject(forKey: "artistName") as! String
        let type = aDecoder.decodeObject(forKey: "type") as! String
        let artistId = aDecoder.decodeObject(forKey: "artistId") as! String
        
        self.init(id: id, title: title, image: image, file: file, artistName: artistName, type: type, artistId: artistId)
    }
    
    
}
