//
//  VideoYeuThichViewController.swift
//  project
//
//  Created by tranthanh on 5/7/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class FavoriteVideoVC: BaseViewController {

    class func newVC() -> FavoriteVideoVC {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: FavoriteVideoVC.className) as! FavoriteVideoVC
    }
    
    var listData  = [Video]()
    
    @IBOutlet weak var tableView: UITableView!
    

   
    func setupTBV(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CellVideo.className, bundle: nil) , forCellReuseIdentifier: CellVideo.className)
        tableView.tableFooterView = UIView()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTBV()
        print(listData)
    }


}


extension FavoriteVideoVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
                          return 0
                     } else {
                         return listData.count
              }
      
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
             return 1
         }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellVideo.className, for: indexPath) as! CellVideo
        cell.bind(item: listData[indexPath.row],index: indexPath.row)
        cell.delegate = self
        return cell
        
      
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          if indexPath.section == 0 {
                     return 200
                 } else {
                     return 100
          }
          
      }
  
   
    
}




extension FavoriteVideoVC : ItemVideoListener {
    
    private func showActionSong(index: Int) {
          let actionMenuAlert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
          
          let actionPlay = UIAlertAction(title: "Play", style: .default, handler: {(_) in
             self.playSong(index: index)
          })
          
          let actionUnfavorite = UIAlertAction(title: "Unfavorite", style: .default, handler: {(_) in
              self.unFavorite(item: self.listData[index])
               
          })
          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in}
          actionMenuAlert.addAction(actionPlay)
          actionMenuAlert.addAction(actionUnfavorite)
          actionMenuAlert.addAction(cancelAction)
          self.checkAlertOnIPad(alertController: actionMenuAlert)
          self.present(actionMenuAlert, animated: true, completion: nil)
      }
    
      func playSong(index: Int)  {
           UIApplication.mainVC()?.maximizePlayerDetailsVideo(item: listData[index], playlistitems: listData)
      }
    
      func unFavorite(item: Video)  {
           let size = FAVORITED_VIDEO.count
           for i in 0...size {
               let song = FAVORITED_VIDEO[i]
               if song.id == item.id{
                   FAVORITED_VIDEO.remove(at: i)
                   break
               }
           }
           listData = FAVORITED_VIDEO
           tableView.reloadData()
           showToast(message: "Un Favourited")
           
       }
    
    func onMenuOption(index: Int) {
        showActionSong(index: index)
    }
    
    func onItemVideoClicked(index: Int) {
        UIApplication.mainVC()?.maximizePlayerDetailsVideo(item: listData[index], playlistitems: listData)
    }
}
