//
//  SongAlbumViewController.swift
//  project
//
//  Created by tranthanh on 5/16/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class SongAlbumViewController: NavLeftViewController {
    override func isNavBar() -> Bool {
        return true
    }
    
    class func newVC() -> SongAlbumViewController {
           let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
           return storyBoard.instantiateViewController(withIdentifier: SongAlbumViewController.className) as! SongAlbumViewController
       }
    
    func setupTbv(){
           tableView.dataSource = self
           tableView.delegate = self
           tableView.register(UINib(nibName: SongTableViewCell.className, bundle: nil), forCellReuseIdentifier: SongTableViewCell.className)
           tableView.tableFooterView = UIView()
        }
    
    @IBOutlet weak var tableView: UITableView!
    
    var songs = [SongItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
       setupTbv()
       setNavTitle(title: "Song")
    }
    

  

}
extension SongAlbumViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int  {
        return songs.count
    }
       
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.className, for: indexPath) as! SongTableViewCell
        let item =  songs[indexPath.row]
        cell.bind(index: indexPath.row, item: item)
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
}

extension SongAlbumViewController : ItemSongCollectionDelegate {
    func onItemDeleted(item: SongItem) {
        
    }
    
    func onShowActionMenu(actionMenu: UIAlertController) {
         present(actionMenu, animated: true, completion: nil)
    }
    
    func onItemClicked(index: Int) {
        UIApplication.mainVC()?.maximizePlayerDetailsMp3(item: songs[index], playlistitems: songs)
    }
    
    

    
}
