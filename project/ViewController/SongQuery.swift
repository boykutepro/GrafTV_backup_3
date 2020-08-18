//
//  SongQuery.swift
//  project
//
//  Created by tranthanh on 5/11/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//
import Foundation
import MediaPlayer
import UIKit




class AlbumOff  {
      var name : String = ""
      var artistName : String = ""
      var albumId : String = ""
      var imageSound : Data? = nil
      var itemCount : String = ""
      var songs = [SongItem]()
}

class SongItem : NSObject, NSCoding {
     var songName : String = ""
     var artistName : String = ""
     var songPath : String = ""
     var mediaItem : MPMediaItem? = nil
     var imageSound : Data? = nil
     var id : String = ""
     var isfavorie : Bool = true 
    
    override init() {
        self.songName = ""
        self.artistName = ""
        self.songPath = ""
        self.id = ""
        
        
    }
    
    init(id: String, songPath: String, artistName: String, songName: String, imageSound : Data){
        self.id = id
        self.songPath = songPath
        self.artistName = artistName
        self.songName = songName
        self.imageSound = imageSound
    }
    
    init(data: [String: AnyObject]) {
           if let id = data["id"] as? String {
               self.id = id
           }
           if let songName = data["songName"] as? String {
               self.songName = songName
           }
           if let artistName = data["artistName"] as? String {
               self.artistName = artistName
           }
           if let songPath = data["songPath"] as? String {
               self.songPath = songPath
           }
           if let imageSound  = data["imageSound"] as? Data {
            self.imageSound  = imageSound
          }

       }
    
     public func encode() -> [String: AnyObject] {
           var dictionary : Dictionary = [String: AnyObject]()
           dictionary["songName"] = songName as AnyObject
           dictionary["artistName"] = artistName as AnyObject
           dictionary["songPath"] = songPath as AnyObject
           dictionary["id"] = id as AnyObject
           dictionary["imageSound"] = id as AnyObject
           return dictionary
    }

    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(songName, forKey: "songName")
        aCoder.encode(artistName, forKey: "artistName")
        aCoder.encode(songPath, forKey: "songPath")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(imageSound, forKey: "imageSound")
        

    }

    
    
    required convenience init?(coder aDecoder: NSCoder) {
        let songName = aDecoder.decodeObject(forKey: "songName") as! String
        let artistName = aDecoder.decodeObject(forKey: "artistName") as! String
        let songPath = aDecoder.decodeObject(forKey: "songPath") as! String
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let imageSound = aDecoder.decodeObject(forKey: "imageSound") as! Data

        self.init(id: id, songPath: songPath, artistName: artistName, songName: songName , imageSound : imageSound)
    }
//
    
    
    
    
    

}



