//
//  DataStoreManager.swift
//  project
//
//  Created by Mac on 8/28/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

extension UserDefaults {
    
    static let  favoritedMP3key = "KEY_MP3"
    func savedMP3() -> [SongItem] {
      guard let savedMP3Data =  UserDefaults.standard.data(forKey: UserDefaults.favoritedMP3key) else { return [] }
      guard let savedMP3s = NSKeyedUnarchiver.unarchiveObject(with: savedMP3Data) as? [SongItem] else { return [] }
      return savedMP3s
     }
    
    func deleteMP3(item: SongItem) {
      let items = savedMP3()
      let filteredMP3 = items.filter { (p) -> Bool in
        return p.songName != item.songName && p.artistName != item.artistName
      }
      let data = NSKeyedArchiver.archivedData(withRootObject: filteredMP3)
      UserDefaults.standard.set(data, forKey: UserDefaults.favoritedMP3key)
    }
    
    func deleteAllMP3() {
         var items = savedMP3()
         items = []
         let data = NSKeyedArchiver.archivedData(withRootObject: items)
         UserDefaults.standard.set(data, forKey: UserDefaults.favoritedMP3key)
    }
}

class DataStoreManager{
    
    // stored key
    let KEY_USER   = "KEY_USER_PREF"
    let KEY_USER_SUBSCRIBE   = "KEY_USER_SUBSCRIBE"
    let KEY_TOKEN_USER   = "KEY_TOKEN_USER"
    let KEY_SETTING_LANGUAGE   = "KEY_SETTING_LANGUAGE"
    let KEY_SETTING_KEEP_SCREEN   = "KEY_SETTING_KEEP_SCREEN"
    let KEY_SETTING_THEME   = "KEY_SETTING_THEME"
    let KEY_SETTING_SHUFFE   = "KEY_SETTING_SHUFFE"
    let KEY_PLAYLIST   = "KEY_PLAYLIST_PREF"
    let KEY_ARTIST   = "KEY_ARTIST"
    
    
    // varieable
    let userDefault = UserDefaults.standard
    
    
    
    
    // singleton
    private static var sharedDefault: DataStoreManager = {
        let object = DataStoreManager()
        return object
    }()
    
    class func shared() -> DataStoreManager {
        return sharedDefault
    }
    
    
    //MARK: USER
    // save user
   
    
    
    func saveShuffe(isKeep : Bool)  {
        userDefault.set(isKeep, forKey: KEY_SETTING_SHUFFE)
    }
    
    func isShuffe() -> Bool {
        return userDefault.bool(forKey: KEY_SETTING_SHUFFE)
    }
    
    // playlist
    
    func saveListPlaylist(_ list:[PlaylistVideo]) {
           UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey:"ListPlaylists")
           UserDefaults.standard.synchronize()
       }
    
    
    
    // playlist
    func savePlaylist(playlist: PlaylistVideo) {
        var playlists = getListPlaylist() ?? []
        let size = playlists.count
        for i in 0 ..< size {
            let item = playlists[i]
            if item.id == playlist.id {
                playlists[i] = playlist
                break
            }
        }
        saveListPlaylist(playlists)
        
    }
    
    func renamePlaylist(playlist: PlaylistVideo) {
        let playlists = getListPlaylist() ?? []
        for item in playlists {
            if item.id == playlist.id {
                
                item.name = playlist.name
                break
            }
        }
        saveListPlaylist(playlists)
        
    }
    
    func removePlaylist(id: String)  {
        var playlists = getListPlaylist() ?? []
        let size = playlists.count
        for i in 0 ..< size {
            let item = playlists[i]
            if item.id == id {
                playlists.remove(at: i)
                break
            }
        }
        
        saveListPlaylist(playlists)
    }
    //
    
   


    func getListPlaylist() -> [PlaylistVideo]? {
        if let data = UserDefaults.standard.value(forKey:"ListPlaylists") as? Data {
            let decodedSports = try? PropertyListDecoder().decode([PlaylistVideo].self, from: data)
            return decodedSports
        }
        return nil
    }

   
    
    func removeItemInPlaylist(playlistId: String, itemId: Int)  {
        var playlists = getListPlaylist() ?? []
        let size = playlists.count
        for i in 0 ..< size {
            let item = playlists[i]
            if item.id == playlistId {
                let childCount = item.videos.count
                for j in 0 ..< childCount {
                    let childObj = item.videos[j]
                    if childObj.id.toInt == itemId {
                        item.videos.remove(at: j)
                        playlists[i] = item
                        break
                    }
                }
                break
            }
        }
        //
        saveListPlaylist(playlists)
    }
    //
//    func loadArtists() {
//        if let bookmarkData = UserDefaults.standard.value(forKey: "ARTISTS") as? [[String: AnyObject]] {
//            for book in bookmarkData {
//                ARTISTS.append(Artist(data: book))
//            }
//        }
//    }
    
    
}



var arrFetchedMedia = NSMutableArray()
var arrFetchedDirMedia = [String]()

func fetchImportedBeat(){
       let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
       let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
       let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
       var theItems = [String]()
       
       if let dirPath = paths.first
       {
           let mediaURL = URL(fileURLWithPath: dirPath)
           
           do {
               theItems = try FileManager.default.contentsOfDirectory(atPath: mediaURL.path)
               arrFetchedDirMedia = theItems
               print(theItems)
           } catch let error as NSError {
               print(error.localizedDescription)
           }
       }
}

var documentURL = { () -> URL in
       let documentURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
       return documentURL
}


var FAVORITED_NHACMP3 = [SongItem]() {
    didSet {
        var items = [[String: AnyObject]]()
        for item in FAVORITED_NHACMP3  {
            items.append(item.encode())
        }
        UserDefaults.standard.set(items, forKey: "FAVORITED_NHACMP3")
    }
}

var FAVORITED_MP3 = [MPMediaItem]() {
    didSet {
        for tempItem in FAVORITED_MP3 {
            var dict = [String:Any]()
            let item: MPMediaItem = tempItem
            let pathURL: URL? = item.value(forProperty: MPMediaItemPropertyAssetURL) as? URL
            if pathURL == nil {
                print("Picking Error")
                return
            }
            let songAsset = AVURLAsset(url: pathURL!, options: nil)
            
            let tracks = songAsset.tracks(withMediaType: .audio)
            
            if(tracks.count > 0){
                let track = tracks[0]
                if(track.formatDescriptions.count > 0){
                    let desc = track.formatDescriptions[0]
                    let audioDesc = CMAudioFormatDescriptionGetStreamBasicDescription(desc as! CMAudioFormatDescription)
                    let formatID = audioDesc?.pointee.mFormatID
                    
                    var fileType:NSString?
                    var ex:String?
                    
                    switch formatID {
                    case kAudioFormatLinearPCM:
                        print("wav or aif")
                        let flags = audioDesc?.pointee.mFormatFlags
                        if( (flags != nil) && flags == kAudioFormatFlagIsBigEndian ){
                            fileType = "public.aiff-audio"
                            ex = "aif"
                        }else{
                            fileType = "com.microsoft.waveform-audio"
                            ex = "wav"
                        }
                        
                    case kAudioFormatMPEGLayer3:
                        print("mp3")
                        fileType = "com.apple.quicktime-movie"
                        ex = "mp3"
                        break;
                        
                    case kAudioFormatMPEG4AAC:
                        print("m4a")
                        fileType = "com.apple.m4a-audio"
                        ex = "m4a"
                        break;
                        
                    case kAudioFormatAppleLossless:
                        print("m4a")
                        fileType = "com.apple.m4a-audio"
                        ex = "m4a"
                        break;
                        
                    default:
                        break;
                    }
                    let exportSession = AVAssetExportSession(asset: AVAsset(url: pathURL!), presetName: AVAssetExportPresetAppleM4A)
                    exportSession?.shouldOptimizeForNetworkUse = true
                    //                    exportSession?.outputFileType = AVFileType.m4a
                    //                    exportSession?.outputFileType = AVFileType(rawValue: fileType! as String) ;
                    exportSession?.outputFileType = AVFileType.m4a ;
                    
                    var fileName = item.value(forProperty: MPMediaItemPropertyTitle) as! String
                    var fileNameArr = NSArray()
                    fileNameArr = fileName.components(separatedBy: " ") as NSArray
                    fileName = fileNameArr.componentsJoined(by: "")
                    fileName = fileName.replacingOccurrences(of: ".", with: "")
                    
                    print("fileName -> \(fileName)")
                    let outputURL = documentURL().appendingPathComponent("\(fileName).m4a")
                    print("OutURL->\(outputURL)")
                    print("fileSizeString->\(item.fileSizeString)")
                    print("fileSize->\(item.fileSize)")
                    
                    dict = [
                        "fileType":fileType as Any,
                        "extention":ex as Any,
                        "title":fileName,
                        "storagePath":outputURL,
                        "size":item.fileSizeString,
                        "isCloudItem":item.isCloudItem
                    ]
                    
                    let namePredicate = NSPredicate(format: "title like %@",dict["title"] as! String);
                    
                    let filteredArray = arrFetchedMedia.filter { namePredicate.evaluate(with: $0) };
                    print("names = ,\(filteredArray)");
                    
                    if(filteredArray.count == 0)
                    {
                        arrFetchedMedia.add(dict)
                    }
                    
                    do {
                        try FileManager.default.removeItem(at: outputURL)
                    } catch let error as NSError {
                        print(error.debugDescription)
                    }
                    
                    exportSession?.outputURL = outputURL
                    exportSession?.exportAsynchronously(completionHandler: { () -> Void in
                        
                        if exportSession!.status == AVAssetExportSession.Status.completed  {
                            DispatchQueue.main.async {
                                
                            }
                            
                            print("Export Successfull")
                            fetchImportedBeat()
                            let arrArchive = NSKeyedArchiver.archivedData(withRootObject: arrFetchedMedia) as NSData
                            
                            let defaults = UserDefaults.standard
                            
                            defaults.set(arrArchive, forKey: "MediaArray")
                            print("arr => \(arrFetchedMedia)")
                            
                            DispatchQueue.main.async {
                              
                            }
                            
                        } else {
                            
                        }
                    })
                }
            }
        }
    }
}

//var listPlaylists = [PlaylistVideo]() {
//    didSet {
//        save_ListPlaylists(listPlaylists)
//    }
//}
//
//func save_ListPlaylists(_ list:[PlaylistVideo]) {
//    UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey:"ListPlaylists")
//    UserDefaults.standard.synchronize()
//}


//func get_ListPlaylists() -> [PlaylistVideo]? {
//    if let data = UserDefaults.standard.value(forKey:"ListPlaylists") as? Data {
//        let decodedSports = try? PropertyListDecoder().decode([PlaylistVideo].self, from: data)
//        return decodedSports
//    }
//    return nil
//}


var FAVORITED_ARTIST = [Video]() {
    didSet {
     save_FAVORITED_ARTIST(FAVORITED_ARTIST)
    }
}

func get_FAVORITED_ARTIST() -> [Video]? {
    if let data = UserDefaults.standard.value(forKey:"FAVORITED_ARTIST") as? Data {
        let decodedSports = try? PropertyListDecoder().decode([Video].self, from: data)
        return decodedSports
    }
    return nil
}

func save_FAVORITED_ARTIST(_ list:[Video]) {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey:"FAVORITED_ARTIST")
    UserDefaults.standard.synchronize()
}


var FAVORITED_CHART = [Video]() {
    didSet {
       save_FAVORITED_CHART(FAVORITED_CHART)
    }
}


func get_FAVORITED_CHART() -> [Video]? {
    if let data = UserDefaults.standard.value(forKey:"FAVORITED_CHART") as? Data {
        let decodedSports = try? PropertyListDecoder().decode([Video].self, from: data)
        return decodedSports
    }
    return nil
}

func save_FAVORITED_CHART(_ list:[Video]) {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey:"FAVORITED_CHART")
    UserDefaults.standard.synchronize()
}


var FAVORITED_VIDEO = [Video]() {
    didSet {
        save_FAVORITED_VIDEO(FAVORITED_VIDEO)
    }
}

func get_FAVORITED_VIDEO() -> [Video]? {
    if let data = UserDefaults.standard.value(forKey:"FAVORITED_VIDEO") as? Data {
        let decodedSports = try? PropertyListDecoder().decode([Video].self, from: data)
        return decodedSports
    }
    return nil
}

func save_FAVORITED_VIDEO(_ list:[Video]) {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey:"FAVORITED_VIDEO")
    UserDefaults.standard.synchronize()
}


var FAVORITED_GENRES = [Video]() {
    didSet {
        save_FAVORITED_GENRES(FAVORITED_GENRES)
    }
}

func get_FAVORITED_GENRES() -> [Video]? {
    if let data = UserDefaults.standard.value(forKey:"FAVORITED_GENRES") as? Data {
        let decodedSports = try? PropertyListDecoder().decode([Video].self, from: data)
        return decodedSports
    }
    return nil
}
func save_FAVORITED_GENRES(_ list:[Video]) {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey:"FAVORITED_GENRES")
    UserDefaults.standard.synchronize()
}


var FAVORITED_SONG = [Song]() {
    didSet {
        var listBook = [[String: AnyObject]]()
        for book in FAVORITED_SONG {
            listBook.append(book.encode())
        }
        UserDefaults.standard.set(listBook, forKey: "FAVORITED_SONG")
    }
}

var DOWNLOADED_SONG = [Song]() {
    didSet {
        var listBook = [[String: AnyObject]]()
        for book in DOWNLOADED_SONG {
            listBook.append(book.encode())
        }
        UserDefaults.standard.set(listBook, forKey: "DOWNLOADED_SONG")
    }
}

var ARTISTS = [Artist]() {
    didSet {
        var listBook = [[String: AnyObject]]()
        for book in ARTISTS {
            
            listBook.append(book.encode())
        }
        UserDefaults.standard.set(listBook, forKey: "ARTISTS")
    }
}



extension MPMediaItem {
    
    // Value is in Bytes
    var fileSize: Int{
        get{
            if let size = self.value(forProperty: "fileSize") as? Int{
                return size
            }
            return 0
        }
    }
    
    var fileSizeString: String{
        let formatter = Foundation.NumberFormatter()
        formatter.maximumFractionDigits = 2
        
        //Byte to MB conversion using 1024*1024 = 1,048,567
        return (formatter.string(from: NSNumber(value: Float(self.fileSize)/1048567.0)) ?? "0") + " MB"
    }
    
    
   
    
  
   
    
}
