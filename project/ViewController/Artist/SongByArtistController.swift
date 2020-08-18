//
//  TacgiaDetailViewController.swift
//  project
//
//  Created by tranthanh on 4/22/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class SongByArtistController: NavLeftViewController {
    
    class func newVC() ->  SongByArtistController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier:  SongByArtistController.className) as!  SongByArtistController
    }
    
    override func isNavBar() -> Bool {
        return true
    }
    
    @IBOutlet weak var tableView: UITableView!
    var listData = [Song]()
    
     var filterByArtist = ""
     var artist: Artist!
    
     func setupTBV(){
           tableView.dataSource = self
           tableView.delegate = self
           tableView.register(UINib(nibName: SongTableViewCell.className, bundle: nil), forCellReuseIdentifier: SongTableViewCell.className)
           tableView.tableFooterView = UIView()
       }
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavTitle(title: artist.title)
         setupTBV()
         getData()
       
    }
    
    func getData() {
            self.listData = artist.getSongsByArtist()
            self.tableView.reloadData()
        }
}


extension SongByArtistController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.className, for: indexPath) as! SongTableViewCell
//          cell.bind(index: indexPath.row, item: self.listData[indexPath.row])
//          cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
       }
       
   

}


extension SongByArtistController : ItemSongCollectionDelegate {
    func onItemDeleted(item: SongItem) {
        
    }
    
    func onShowActionMenu(actionMenu: UIAlertController) {
       present(actionMenu, animated: true, completion: nil)
    }
    
    func onItemClicked(index: Int) {
       QueuItemManager.shared().addNewQueue(items: self.listData)
       QueuItemManager.shared().currentPosition = index
       NotificationCenter.default.post(name: NSNotification.Name(NotificationID.PLAY), object:nil, userInfo: ["data":""])
    }
    

    func onItemDeleted(index: Int) {
         let item = self.listData[index]
               if item.type == "2" {
                   for i in 0..<DOWNLOADED_SONG.count{
                       let object = DOWNLOADED_SONG[i]
                       if object.id == item.id {
                           DOWNLOADED_SONG.remove(at: i)
                           self.deleteFile(url: item.getUrl()!)
                           break
                       }
                   }
               }else {
                   self.deleteFile(url: item.getUrl()!)
               }
               
               self.listData.remove(at: index)
               self.tableView.reloadData()
    }
    func deleteFile(url: URL)  {
        do {
            let fileManager = FileManager.default
            try fileManager.removeItem(at: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func onItemAddToQueue(index: Int) {
         QueuItemManager.shared().addItemToQueue(item: self.listData[index])
         self.showToast(message: "Added to queue")
    }
    
    
}
