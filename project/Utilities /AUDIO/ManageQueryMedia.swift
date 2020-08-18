//
//  ManageQueryMedia.swift
//  project
//
//  Created by tranthanh on 4/22/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import Foundation
import MediaPlayer

class ManageQueryMedia{
    
    class func queryAllSongs()-> [Song]{
        var listSongs = [Song]()
        
        let query = MPMediaQuery.songs()
    
        if let collections = query.items {
            for item in collections {
                
                let name = item.value(forKey: MPMediaItemPropertyTitle) as! String
                let artist = item.value(forKey: MPMediaItemPropertyArtist) as! String
                
                let artWork = item.value(forKey: MPMediaItemPropertyArtwork) as! MPMediaItemArtwork
                let image = artWork.image(at: CGSize(width: 60, height: 60))
                
                let url = item.value(forKey: MPMediaItemPropertyAssetURL) as! NSURL
                
                let song = Song(title: name, artist: artist, artwork: image!, url: url.absoluteString!, type: "1")
                listSongs.append(song)
            }
        }
        return listSongs
    }
    
    class func queryAllSongsByArtist(artist: String)-> [Song]{
        var listSongs = [Song]()
        
        let query = MPMediaQuery.songs()
        query.addFilterPredicate(MPMediaPropertyPredicate(value: artist, forProperty: MPMediaItemPropertyArtist))
        
        if let collections = query.items {
            for item in collections {
                let name = item.value(forKey: MPMediaItemPropertyTitle) as! String
                let artist = item.value(forKey: MPMediaItemPropertyArtist) as! String
                let artWork = item.value(forKey: MPMediaItemPropertyArtwork) as! MPMediaItemArtwork
                let image = artWork.image(at: CGSize(width: 60, height: 60))
                let url = item.value(forKey: MPMediaItemPropertyAssetURL) as! NSURL
                let song = Song(title: name, artist: artist, artwork: image!, url: url.absoluteString!, type: "1")
                listSongs.append(song)
            }
        }
        return listSongs
    }
    
    class func queryArtists()-> [Artist]{
        var listSongs = [Artist]()
       
        let query = MPMediaQuery.artists()
        query.addFilterPredicate(MPMediaPropertyPredicate(value: MPMediaType.music.rawValue, forProperty: MPMediaItemPropertyMediaType))
        
        if let collections = query.collections {
           
            for item in collections {
                var artistName = ""
                if let representativeItem = item.representativeItem {
                    artistName = representativeItem.artist!
                }
                let count = item.count
                let object = Artist(title: artistName, count: count)
                listSongs.append(object)
               
            }
        }
        return listSongs
    }
  
    
    class func querySongDownloaded() -> [Song]{
        var listDownloaded = [Song]()
        let listSongs = queryAllSongs()
        do{
            let url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            for song in listSongs{
                if(song.url.hasPrefix(url.path)){
                    listDownloaded.append(song)
                }
            }
            
        } catch{
            print("\(error)")
        }
        return listDownloaded
    }
}

