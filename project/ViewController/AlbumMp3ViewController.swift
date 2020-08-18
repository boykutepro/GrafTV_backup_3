//
//  AlbumsViewController.swift
//  project
//
//  Created by tranthanh on 5/11/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import MediaPlayer

class AlbumMp3ViewController: BaseViewController {
    
    var allAlbumItems = [AlbumOff]()
     /// Get all albums and their songs
    ///
    
    
    func getAllAlbums() {
        let query: MPMediaQuery = MPMediaQuery.albums()
        let allAlbums = query.collections

        allAlbumItems.removeAll()

        guard allAlbums != nil else {
            return
        }

        for collection in allAlbums! {
            let item: MPMediaItem? = collection.representativeItem

            let albumName = item?.value(forKey: MPMediaItemPropertyAlbumTitle) as? String ?? "<Unknown>"
            let albumId = item?.value(forProperty: MPMediaItemPropertyAlbumPersistentID) as! NSNumber
            let artistName = item?.value(forKey: MPMediaItemPropertyArtist) as? String ?? "<Unknown>"
            let imageSound = item?.value(forProperty: MPMediaItemPropertyArtwork) as? MPMediaItemArtwork
            let itemCount =  item?.value(forProperty: MPMediaItemPropertyAlbumTrackCount) as! NSNumber
            let imageView = imageSound?.image(at: .zero)
            let dataImage = imageView?.jpegData(compressionQuality: 0.9)
            let album = AlbumOff()
            album.name = albumName
            album.artistName = artistName
            album.albumId = String(describing: albumId)
            album.imageSound = dataImage ?? Data()
            album.itemCount = String(describing: itemCount)
            print("Album name: \(albumName)")

            // Get all songs in this album
            let mediaQuery = MPMediaQuery.songs()
            let predicate = MPMediaPropertyPredicate.init(value: albumId, forProperty: MPMediaItemPropertyAlbumPersistentID)
            mediaQuery.addFilterPredicate(predicate)
            let song = mediaQuery.items

            if let allSongs = song {
                var index = 0

                for item in allSongs {
                    let pathURL: URL? = item.value(forProperty: MPMediaItemPropertyAssetURL) as? URL
                    if pathURL == nil {
                        print("@Warning!!! Track : \(item) is not playable.")
                    } else {
                        let trackInfo = SongItem()

                        trackInfo.mediaItem = item

                        let title = item.value(forProperty: MPMediaItemPropertyTitle) as? String ?? "<Unknown>"
                        let artistName = item.value(forProperty: MPMediaItemPropertyArtist) as? String ?? "<Unknown>"
                        let imageSound = item.value(forProperty: MPMediaItemPropertyArtwork) as? MPMediaItemArtwork
                      
                        let pathURL: URL? = item.value(forProperty: MPMediaItemPropertyAssetURL) as? URL
                        let imageView = imageSound?.image(at: .zero)
                        let dataImage = imageView?.jpegData(compressionQuality: 0.9)
                    
                        trackInfo.songName = title
                        trackInfo.artistName = artistName
                        trackInfo.imageSound = dataImage ?? Data()
                        trackInfo.songPath = pathURL!.absoluteString
                        trackInfo.imageSound = dataImage ?? #imageLiteral(resourceName: "background").jpegData(compressionQuality: 1)
                        album.songs.append(trackInfo)
                        index += 1
                    }
                }

            }

            // Finally add the album object to albums array
            allAlbumItems.append(album)

        }


        print("Total Album count: \(allAlbumItems.count)")

    }
    
    let player: AVPlayer = {
      let avPlayer = AVPlayer()
      avPlayer.automaticallyWaitsToMinimizeStalling = false
      return avPlayer
    }()
     var avPlayer : AVPlayer?

    
    class func newVC() -> AlbumMp3ViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: AlbumMp3ViewController.className) as! AlbumMp3ViewController
    }

 
    @IBOutlet weak var tableView: UITableView!
    
    func setTable(){
        tableView.register(UINib(nibName: CellAlbumMp3.className, bundle: nil), forCellReuseIdentifier: CellAlbumMp3.className)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

          getAllAlbums()
        setTable()
    }
    
    

}




extension AlbumMp3ViewController : UITableViewDataSource , UITableViewDelegate {

    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int  {
         return allAlbumItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: CellAlbumMp3.className, for: indexPath) as! CellAlbumMp3
        cell.bind(index: indexPath.row, item: allAlbumItems[indexPath.row])
        return cell
    }
    
    
  
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let songAlbumVC = SongAlbumViewController.newVC()
        let items =  allAlbumItems[indexPath.row].songs
        let itemsAff = Array(items)
        songAlbumVC.songs = itemsAff 
        self.navigationController?.pushViewController(songAlbumVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
}



