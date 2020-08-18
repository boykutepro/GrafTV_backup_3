//
//  NhacOfflineYeuThich.swift
//  project
//
//  Created by tranthanh on 5/13/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit


class NhacOfflineViewController: BaseViewController {
//    var items = UserDefaults.standard.savedMP3()
   
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    var listData = [SongItem]()
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBAction func btnClearAll(_ sender: Any) {
        showActionMenu()
    }
    
    
    class func newVC() -> NhacOfflineViewController {
             let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
             return storyBoard.instantiateViewController(withIdentifier: NhacOfflineViewController.className) as! NhacOfflineViewController
    }
         
    func setupTbv(){
       tableView.dataSource = self
       tableView.delegate = self
       tableView.register(UINib(nibName: SongTableViewCell.className, bundle: nil), forCellReuseIdentifier: SongTableViewCell.className)
       tableView.tableFooterView = UIView()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listData = FAVORITED_NHACMP3
         lblTitle.text = "Nhạc OffLine"
         setupTbv()
       
    }
    
    private func showActionMenu(){
        let actionMenuAlert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let actionClearAll = UIAlertAction(title: "Clear all", style: .default, handler: {(_) in
            self.unFavoriteAll()
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in}
        actionMenuAlert.addAction(actionClearAll)
        actionMenuAlert.addAction(cancelAction)
        self.checkAlertOnIPad(alertController: actionMenuAlert)
        self.present(actionMenuAlert, animated: true, completion: nil)
    }
    
    func unFavoriteAll()  {
        if listData.count > 0 {
                   FAVORITED_SONG.removeAll()
                   showToast(message: "Removed all")
                   listData.removeAll()
                   tableView.reloadData()
               }
    }
    
}


extension NhacOfflineViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int  {
        return listData.count
    }
       
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.className, for: indexPath) as! SongTableViewCell
        cell.btnMore.isEnabled = true
        cell.imgMore.isHidden = false
        let item = listData[indexPath.row]
        cell.bind(index: indexPath.row, item: item)
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension NhacOfflineViewController : ItemSongCollectionDelegate {
    func onShowActionMenu(actionMenu: UIAlertController) {
         present(actionMenu, animated: true, completion: nil)
    }
    
    func onItemClicked(index: Int) {
        UIApplication.mainVC()?.maximizePlayerDetailsMp3(item: listData[index], playlistitems: listData)
    }
    
    func onItemDeleted(item: SongItem) {
        let size = FAVORITED_NHACMP3.count
        for i in 0...size {
            let song = FAVORITED_NHACMP3[i]
            if song.id == item.id{
                FAVORITED_NHACMP3.remove(at: i)
                break
            }
        }
        listData = FAVORITED_NHACMP3
        tableView.reloadData()
        showToast(message: "Un Favourited")
    }
    
}

