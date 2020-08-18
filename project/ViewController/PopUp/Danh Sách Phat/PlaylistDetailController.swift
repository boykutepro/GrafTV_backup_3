//
//  AlbumsDetailController.swift
//  project
//
//  Created by Trang Pham on 1/15/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import UIKit


protocol IOnPlistDetailDelegate {
    func onPlaylistDetailRefresh()
    func onPlaylistDeleted()
}

class PlaylistDetailController: BaseViewController, ItemVideoListener {
    class func newVC() ->  PlaylistDetailController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier:  PlaylistDetailController.className) as!  PlaylistDetailController
    }

    @IBAction func btnShowMenu(_ sender: Any) {
        self.showMenuActionPlaylist()
    }
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgContainer: UIImageView!
    func getData()  {
       let playlists = DataStoreManager.shared().getListPlaylist() ?? []
        for playlist in playlists {
            if playlist.id == self.item.id{
                self.item = playlist
                break
            }
        }
        
        listData = item.videos
        tableView.reloadData()
    }
    
    
    func setData()  {
        lblName.text = item.name
        imgView.setImage(url: item.image)
        imgContainer.setImage(url: item.image)
    }
    

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
   
    
    var delegate: IOnPlistDetailDelegate!
    
    var listData: [Video] = [Video]()
    var item: PlaylistVideo!
    
    let heightSceen: CGFloat = UIScreen.main.bounds.height
    let widthSceen: CGFloat = UIScreen.main.bounds.width
    
    var statusBarHeight = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
        getData()
        setData()
    }
   
   
    
    

    
    func initTable()  {
        tableView.register(UINib(nibName: CellVideo.className, bundle: nil), forCellReuseIdentifier: CellVideo.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    

    
    func onMenuOption(index: Int) {
        self.showActionVideoPlaylist(item: self.listData[index]) {
            self.item.videos.remove(at: index)
            self.getData()
            self.setData()
            self.delegate.onPlaylistDeleted()
            self.showToast(message: "Removed")
        }
    }
    
   
    
     func onItemVideoClicked(index: Int) {
        UIApplication.mainVC()?.maximizePlayerDetailsVideo(item: listData[index], playlistitems: listData)
    }

    func showMenuActionPlaylist()  {
        let alertController = UIAlertController(title: "Menu", message: "", preferredStyle: .actionSheet)
        let twoAction = UIAlertAction(title: "Change name playlist", style: .default) { (_) in
            self.showRenamePlaylist()
        }
        let threeAction = UIAlertAction(title: "Remove playlist", style: .default) { (_) in
            self.showRemovePlaylist()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
        }

        alertController.addAction(twoAction)
        alertController.addAction(threeAction)
        alertController.addAction(cancelAction)
        self.checkAlertOnIPad(alertController: alertController)
        self.present(alertController, animated: true)
    }
    
    private func showRenamePlaylist(){
        let alert = UIAlertController(title: "Rename", message: "", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default, handler: {(_) in
            if let title = alert.textFields?[0].text{
                self.item.name = title
                DataStoreManager.shared().renamePlaylist(playlist: self.item)
                self.lblName.text = title
                self.delegate.onPlaylistDeleted()
                self.notiffyNeedToUpdate()
                alert.dismiss(animated: true, completion: nil)
            }
            //self.showToast(message: "Successfully!")
        })
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addTextField { (textField) in
            textField.text = self.item.name
        }
        actionOk.isEnabled = true
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        self.checkAlertOnIPad(alertController: alert)
        self.present(alert, animated: true, completion: nil)
    }

    func showRemovePlaylist()  {
        let alert = UIAlertController(title: "", message: "Do you want to remove this playlist?", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default, handler: {(_) in
            self.removePlaylist()
        })
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_) in
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func removePlaylist()  {
        DataStoreManager.shared().removePlaylist(id: self.item.id)
        self.showToast(message: "Removed")
        self.delegate.onPlaylistDeleted()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func gotoSongList() {
//        songController = SongListAddController()
//        songController.navDelegate = self
//        songController.item = self.item
//        self.add(asChildViewController: songController)
    }
    
    func onBackController(tag: String) {
        getData()
        setData()
    }
    
    func notiffyNeedToUpdate(){
         NotificationCenter.default.post(name: NSNotification.Name(NotificationID.UPDATE_PLAYLIST), object:nil, userInfo: nil)
    }
    
}

extension PlaylistDetailController: UITableViewDataSource , UITableViewDelegate {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listData.count
       }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
           let cell = tableView.dequeueReusableCell(withIdentifier: CellVideo.className, for: indexPath) as! CellVideo
                               if listData.count == 0 {return cell}
                               let item = listData[indexPath.row]
                               cell.bind(item: item, index: indexPath.row)
                               cell.delegate = self
                               return cell
             
        
           
         }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
         
    
  
    
   
}



