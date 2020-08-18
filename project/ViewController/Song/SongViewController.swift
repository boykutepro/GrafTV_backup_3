//
//  SongViewController.swift
//  project
//
//  Created by tranthanh on 4/15/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import MediaPlayer


class  ImageUtils {
   class func loadImageFromPath(path: NSString) -> UIImage? {

        let image = UIImage(contentsOfFile: path as String)

        if image == nil {
            return UIImage()
        } else{
            return image
        }
    }
}
class Utils {
    class func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        //print("Path: \(documentsDirectory)")
        return documentsDirectory as NSString
    }
    
     
}

class MyImageStorage{
     var imagePath: NSString?
}


var documentsPath : URL {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      let documentDirectory = paths[0]
      return documentDirectory
  }
  
  
  var imgUrl : URL {
       return documentsPath.appendingPathComponent("myimage.jpg")
   }


func filePath(songId : String) -> URL? {
       let fileManager = FileManager.default
       guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
       
       return documentURL.appendingPathComponent(songId + ".pnge")
    
}

 
  class SongViewController: UIViewController , MPMediaPickerControllerDelegate {
    var allSongItems = [SongItem]()

    
    class func newVC() -> SongViewController {
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: SongViewController.className) as! SongViewController
      }

  
    
       
    
    func loadImageFromName(_ imgName: String) -> UIImage? {
         guard  imgName.count > 0 else {
             print("ERROR: No image name")
             return UIImage()
         }

         let imgPath = Utils.getDocumentsDirectory().appendingPathComponent(imgName) as NSString
         let image = ImageUtils.loadImageFromPath(path: imgPath)
         return image
     }
    
    
 
    
    func loadImageFromPath(_ path: NSString) -> UIImage? {
        let image = UIImage(contentsOfFile: path as String)

        if image == nil {
            return UIImage()
        } else{
            return image
        }
    }
    
   
  
  
    
    
 
    @IBOutlet weak var tableView: UITableView!

    func setupTbv(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: SongTableViewCell.className, bundle: nil), forCellReuseIdentifier: SongTableViewCell.className)
        tableView.tableFooterView = UIView()
     }
    override func viewDidLoad() {
        super.viewDidLoad()
           setupTbv()
           getAllSongs()
        
    
       

     }
    
    func getAllSongs() {
            let query: MPMediaQuery = MPMediaQuery.songs()
            let allSongs = query.collections

            allSongItems.removeAll()

            guard allSongs != nil else {
                return
            }

            for collection in allSongs! {
                let item: MPMediaItem? = collection.representativeItem
                let title = item?.value(forProperty: MPMediaItemPropertyTitle) as? String ?? "<Unknown>"
                let artistName = item?.value(forProperty: MPMediaItemPropertyArtist) as? String ?? "<Unknown>"
                let imageSound = item?.value(forProperty: MPMediaItemPropertyArtwork) as? MPMediaItemArtwork
                let songId = item?.value(forProperty: MPMediaItemPropertyPersistentID) as! NSNumber
                let pathURL: URL? = item?.value(forProperty: MPMediaItemPropertyAssetURL) as? URL
                let imageView = imageSound?.image(at: .zero)
                let dataImage = imageView?.jpegData(compressionQuality: 0.9)
//
//
//

                 let trackInfo = SongItem()
                 trackInfo.songName = title
                 trackInfo.artistName = artistName
                 trackInfo.imageSound = dataImage ?? Data()
                 trackInfo.mediaItem = item
                 trackInfo.id = String(describing: songId)
                 trackInfo.songPath = pathURL!.absoluteString
                 trackInfo.imageSound = dataImage ?? #imageLiteral(resourceName: "background").jpegData(compressionQuality: 1)

                 allSongItems.append(trackInfo)
             
            }


            print("Total Album count: \(allSongItems.count)")

        }
  
  
}
//
extension SongViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int  {
      
        return allSongItems.count
    }
       
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.className, for: indexPath) as! SongTableViewCell
        let item = allSongItems[indexPath.row]
        cell.bind(index: indexPath.row, item: item)
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
}

extension SongViewController : ItemSongCollectionDelegate {
    func onItemDeleted(item: SongItem) {
        
    }
    
    func onShowActionMenu(actionMenu: UIAlertController) {
         present(actionMenu, animated: true, completion: nil)
    }
    
    func onItemClicked(index: Int) {
        UIApplication.mainVC()?.maximizePlayerDetailsMp3(item: allSongItems[index], playlistitems: allSongItems)
       
    }
    
    func onItemDeleted(index: Int) {
          allSongItems.remove(at: index)
          self.tableView.reloadData()

    }

}
